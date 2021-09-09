<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ax" uri="http://axisj.com/axu4j" %>

<ax:layout name="base.jsp">
    <ax:set name="title" value="${PAGE_NAME}" />
    <ax:set name="page_desc" value="${PAGE_REMARK}" />
    <ax:div name="contents">
        <ax:row>
            <ax:col size="12">
                <ax:custom customid="page-button" pageId="${PAGE_ID}" searchAuth="${SEARCH_AUTH}" saveAuth="${SAVE_AUTH}" excelAuth="${EXCEL_AUTH}" function1Auth="${FUNCTION_1_AUTH}" function2Auth="${FUNCTION_2_AUTH}" function3Auth="${FUNCTION_3_AUTH}" function4Auth="${FUNCTION_4_AUTH}" function5Auth="${FUNCTION_5_AUTH}"></ax:custom>


                <ax:custom customid="table">
                    <ax:custom customid="tr">
                        <ax:custom customid="td" style="width:500px;">
                            <div class="ax-button-group">
                            <div class="right">
                            <button type="button" class="AXButton" id="ax-btn-search"><i class="axi axi-search"></i>조회</button>
                            </div>
                            </div>
                        	<div class="ax-search" id="page-search-box"></div>
                            <div class="ax-grid" id="page-grid-box" style="min-height: 300px;"></div>
                        </ax:custom>

                        <ax:custom customid="td">
                            <div class="ax-button-group">
                            <div class="right">
	                            <button type="button" class="AXButton" id="ax-btn-excel"><i class="axi axi-file-excel-o"></i>엑셀</button>
	                            <button type="button" class="AXButton" id="ax-btn-print"><i class="axi axi-print"></i>출력</button>
                            </div>
                            </div>
                        	<!-- <div class="ax-search" id="page-search2-box"></div> -->
                            <ax:form id="form-info" name="form-info" method="get">
                                <ax:fields>
                                    <ax:field label="영수증구분" style="height:10px">
                                         <select id="receipt" class="AXInput"></select>
                                         <span id="deadInfo"></span>
                                    </ax:field>
                                </ax:fields>
                            </ax:form>
							<iframe id="reportDisplay" src="" style="width:99%; min-height:800px; border:none;"></iframe>


                        </ax:custom>
                    </ax:custom>
                </ax:custom>

            </ax:col>
        </ax:row>
    </ax:div>
    <ax:div name="scripts">
    	<script type="text/javascript" src="/static/js/common/ezcard.js?V=1"></script>
        <script type="text/javascript">
            var resize_elements = [
                {id:"page-grid-box", adjust:-97}
            ];
            var fnObj = {
                CODES: {
                	deadSex: Common.getCode("TCM05")
                },
                pageStart: function(){
                	var params;
                	this.dateFormat();
                    this.search.bind();
                    this.grid.bind();
                    this.form.bind();
                    this.bindEvent();
                    // 페이지 로딩 후 바로 검색 처리하기 (option)
                    setTimeout(function(){
                   		fnObj.search.submit();
                    }, 500);
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
                    $("#ax-page-btn-excel").bind("click", function(){
						fnObj.excel(fnObj.pageStart.params);
                    });
                    $("#ax-btn-search").bind("click", function(){
                        _this.search.submit();
                    });
                    $("#ax-btn-excel").bind("click", function(){
						fnObj.excel(fnObj.pageStart.params);
                    });
                    $("#ax-btn-print").bind("click", function(){
						fnObj.print();
                    });
                },

                dateFormat: function(){
               		Date.prototype.yyyymmdd = function() {
               		  var mm = this.getMonth() + 1; // getMonth() is zero-based
               		  var dd = this.getDate();

               		  var result = [this.getFullYear(),
               		          (mm>9 ? '' : '0') + mm,
               		          (dd>9 ? '' : '0') + dd
               		         ].join('-');

               		  return result;
               		};
                },

                template: {
                	deleteKeywords: function(str){
						return str.replace(/\[[^\[.*\]]*/gi, "").replace(/\]/g, "");
					}
					, cashStmt: function(){
						var s = Ez.s;
						var str = [];

						str.push(s.start+s.align.left+s.font.size("21")+"[title]	"+s.font.size("01"));
						str.push("등록번호 : 124-82-11056");
						str.push("상	    호 : 수원도시공사");
						str.push("성	    명 : 이부영");
						str.push("소 재 지 : 경기 수원 영통 하 25");
						str.push("업	    태 : 서비스업");
						str.push("종	    목 : 공공시설물운영");
						str.push(s.br);
						str.push("거래일자 : [etDate]");
						str.push(s.br);
						str.push("면세금액 : "+s.font.size("21")+"[noTaxAmt]"+s.font.size("01")+" 원");
						str.push("과세금액 : "+s.font.size("21")+"[netAmt]"+s.font.size("01")+" 원");
						str.push("부 가 세 : "+s.font.size("21")+"[vatAmt]"+s.font.size("01")+" 원");
						str.push("합    계 : "+s.font.size("21")+"[totAmt]"+s.font.size("01")+" 원");
						str.push(s.br);
						str.push("고유번호 : [cardNo]");
						str.push("승인번호 : "+s.font.size("21")+"[appNo]"+s.font.size("01")+"");
						str.push("알    림 : 자진발급 소득공제신청은");
						str.push("           http://www.taxsave.go.kr");
						str.push(s.br);
						str.push("<회원용>");
						str.push("   고인명:[deadName]([binsoName])");
						str.push("   이용해 주셔서 감사합니다.");
						str.push(s.br);
						str.push(new Date().print("yyyy년mm월dd일 hh시mi분"));
						str.push(s.br);
						str.push(s.cutting);

						str.push(s.align.left+s.font.size("21")+"[title]	"+s.font.size("01"));
						str.push("등록번호 : 124-82-11056");
						str.push("상	    호 : 수원도시공사");
						str.push("성	    명 : 이부영");
						str.push("소 재 지 : 경기 수원 영통 하 25");
						str.push("업	    태 : 서비스업");
						str.push("종	    목 : 공공시설물운영");
						str.push(s.br);
						str.push("거래일자 : [etDate]");
						str.push(s.br);
						str.push("면세금액 : "+s.font.size("21")+"[noTaxAmt]"+s.font.size("01")+" 원");
						str.push("과세금액 : "+s.font.size("21")+"[netAmt]"+s.font.size("01")+" 원");
						str.push("부 가 세 : "+s.font.size("21")+"[vatAmt]"+s.font.size("01")+" 원");
						str.push("합    계 : "+s.font.size("21")+"[totAmt]"+s.font.size("01")+" 원");
						str.push(s.br);
						str.push("고유번호 : [cardNo]");
						str.push("승인번호 : "+s.font.size("21")+"[appNo]"+s.font.size("01")+"");
						str.push("알    림 : 자진발급 소득공제신청은");
						str.push("           http://www.taxsave.go.kr");
						str.push(s.br);
						str.push("<보관용>");
						str.push("   고인명:[deadName]([binsoName])");
						str.push(s.br);
						str.push(new Date().print("yyyy년mm월dd일 hh시mi분"));
						str.push(s.br);
						str.push(s.cutting+s.br);

						return str.join(s.br);
					}
					, cashStmt2: function(){
						var s = Ez.s;
						var str = [];

						str.push(s.start+s.align.left+s.font.size("21")+"[title]	"+s.font.size("01"));
						str.push("등록번호 : 124-82-11056");
						str.push("상	    호 : 수원도시공사");
						str.push("성	    명 : 이부영");
						str.push("소 재 지 : 경기 수원 영통 하 25");
						str.push("업	    태 : 서비스업");
						str.push("종	    목 : 공공시설물운영");
						str.push(s.br);
						str.push("거래일자 : [etDate]");
						str.push(s.br);
						str.push("면세금액 : "+s.font.size("21")+"[noTaxAmt]"+s.font.size("01")+" 원");
						str.push("과세금액 : "+s.font.size("21")+"[netAmt]"+s.font.size("01")+" 원");
						str.push("부 가 세 : "+s.font.size("21")+"[vatAmt]"+s.font.size("01")+" 원");
						str.push("합    계 : "+s.font.size("21")+"[totAmt]"+s.font.size("01")+" 원");
						str.push(s.br);
						str.push("<회원용>");
						str.push("   고인명:[deadName]([binsoName])");
						str.push("   이용해 주셔서 감사합니다.");
						str.push(s.br);
						str.push(new Date().print("yyyy년mm월dd일 hh시mi분"));
						str.push(s.br);
						str.push(s.cutting);

						str.push(s.align.left+s.font.size("21")+"[title]	"+s.font.size("01"));
						str.push("등록번호 : 124-82-11056");
						str.push("상	    호 : 수원도시공사");
						str.push("성	    명 : 이부영");
						str.push("소 재 지 : 경기 수원 영통 하 25");
						str.push("업	    태 : 서비스업");
						str.push("종	    목 : 공공시설물운영");
						str.push(s.br);
						str.push("거래일자 : [etDate]");
						str.push(s.br);
						str.push("면세금액 : "+s.font.size("21")+"[noTaxAmt]"+s.font.size("01")+" 원");
						str.push("과세금액 : "+s.font.size("21")+"[netAmt]"+s.font.size("01")+" 원");
						str.push("부 가 세 : "+s.font.size("21")+"[vatAmt]"+s.font.size("01")+" 원");
						str.push("합    계 : "+s.font.size("21")+"[totAmt]"+s.font.size("01")+" 원");
						str.push(s.br);
						str.push("<보관용>");
						str.push("   고인명:[deadName]([binsoName])");
						str.push(s.br);
						str.push(new Date().print("yyyy년mm월dd일 hh시mi분"));
						str.push(s.br);
						str.push(s.cutting+s.br);

						return str.join(s.br);
					}
					, cardStmt: function(){
						var s = Ez.s;
						var str = [];

						str.push(s.start+s.align.left+s.font.size("21")+"카드영수증	"+s.font.size("01"));
						str.push("등록번호 : 124-82-11056");
						str.push("상	    호 : 수원도시공사");
						str.push("성	    명 : 이부영");
						str.push("소 재 지 : 경기도 수원시 장안구 장안로 134 (정자");
						str.push("업	    태 : 서비스업");
						str.push("종	    목 : 공공시설물운영");
						str.push(s.br);
						str.push(s.font.size("21")+"[cardName]");
						str.push(s.font.size("01")+"[cardNo]");
						str.push(s.br);
 						str.push("유효기간 : **/**");
 						str.push("가맹번호 : [aquirer]");
 						str.push("거래일자 : [etDate]");
 						str.push("거래구분 : [halbu]");
 						str.push("단말번호 : [tid]");
						str.push(s.br);
						str.push("면세금액 : "+s.font.size("21")+"[noTaxAmt]"+s.font.size("01")+" 원");
						str.push("과세금액 : "+s.font.size("21")+"[netAmt]"+s.font.size("01")+" 원");
						str.push("부 가 세 : "+s.font.size("21")+"[vatAmt]"+s.font.size("01")+" 원");
						str.push("합    계 : "+s.font.size("21")+"[totAmt]"+s.font.size("01")+" 원");
						str.push(s.br);
						str.push("승인번호 : "+s.font.size("21")+"[appNo]"+s.font.size("01")+"");
						str.push("거래번호 : [buyNo]");
						str.push("매 입 사 : [cardName]");
						str.push("알    림 : [notice]");
						str.push(s.br);
						str.push("서명 :  ______________________");
						str.push("   고인명:[deadName]([binsoName])");
						str.push(s.br);
						str.push(new Date().print("yyyy년mm월dd일 hh시mi분"));
						str.push(s.br);
						str.push(s.cutting);

						str.push(s.align.left+s.font.size("21")+"카드영수증	"+s.font.size("01"));
						str.push("등록번호 : 124-82-11056");
						str.push("상	    호 : 수원도시공사");
						str.push("성	    명 : 이부영");
						str.push("소 재 지 : 경기도 수원시 장안구 장안로 134 (정자");
						str.push("업	    태 : 서비스업");
						str.push("종	    목 : 공공시설물운영");
						str.push(s.br);
						str.push(s.font.size("21")+"[cardName]");
						str.push(s.font.size("01")+"[cardNo]");
						str.push(s.br);
 						str.push("유효기간 : **/**");
 						str.push("가맹번호 : [aquirer]");
 						str.push("거래일자 : [etDate]");
 						str.push("거래구분 : [halbu]");
 						str.push("단말번호 : [tid]");
						str.push(s.br);
						str.push("면세금액 : "+s.font.size("21")+"[noTaxAmt]"+s.font.size("01")+" 원");
						str.push("과세금액 : "+s.font.size("21")+"[netAmt]"+s.font.size("01")+" 원");
						str.push("부 가 세 : "+s.font.size("21")+"[vatAmt]"+s.font.size("01")+" 원");
						str.push("합    계 : "+s.font.size("21")+"[totAmt]"+s.font.size("01")+" 원");
						str.push(s.br);
						str.push("승인번호 : "+s.font.size("21")+"[appNo]"+s.font.size("01")+"");
						str.push("거래번호 : [buyNo]");
						str.push("매 입 사 : [cardName]");
						str.push("알    림 : [notice]");
						str.push(s.br);
						str.push("<회원용>");
						str.push("   고인명:[deadName]([binsoName])");
						str.push("   이용해 주셔서 감사합니다.");
						str.push(s.br);
						str.push(new Date().print("yyyy년mm월dd일 hh시mi분"));
						str.push(s.br);
						str.push(s.cutting);

						str.push(s.align.left+s.font.size("21")+"카드영수증	"+s.font.size("01"));
						str.push("등록번호 : 124-82-11056");
						str.push("상	    호 : 수원도시공사");
						str.push("성	    명 : 이부영");
						str.push("소 재 지 : 경기도 수원시 장안구 장안로 134 (정자");
						str.push("업	    태 : 서비스업");
						str.push("종	    목 : 공공시설물운영");
						str.push(s.br);
						str.push(s.font.size("21")+"[cardName]");
						str.push(s.font.size("01")+"[cardNo]");
						str.push(s.br);
 						str.push("유효기간 : **/**");
 						str.push("가맹번호 : [aquirer]");
 						str.push("거래일자 : [etDate]");
 						str.push("거래구분 : [halbu]");
 						str.push("단말번호 : [tid]");
						str.push(s.br);
						str.push("면세금액 : "+s.font.size("21")+"[noTaxAmt]"+s.font.size("01")+" 원");
						str.push("과세금액 : "+s.font.size("21")+"[netAmt]"+s.font.size("01")+" 원");
						str.push("부 가 세 : "+s.font.size("21")+"[vatAmt]"+s.font.size("01")+" 원");
						str.push("합    계 : "+s.font.size("21")+"[totAmt]"+s.font.size("01")+" 원");
						str.push(s.br);
						str.push("승인번호 : "+s.font.size("21")+"[appNo]"+s.font.size("01")+"");
						str.push("거래번호 : [buyNo]");
						str.push("매 입 사 : [cardName]");
						str.push("알    림 : [notice]");
						str.push(s.br);
						str.push("<가맹점용>");
						str.push("   고인명:[deadName]([binsoName])");
						str.push(s.br);
						str.push(new Date().print("yyyy년mm월dd일 hh시mi분"));
						str.push(s.br);
						str.push(s.cutting+s.br);

						return str.join(s.br);
					}
				},
				draw: {

					drawCashStmt: function(funeral, payment, stmt){

						var template = fnObj.template[stmt]();

	//						str.push(s.font.size("21")+"[title]	"+s.font.size("01"));
	//						str.push("등록번호 : 124-82-11056");
	//						str.push("성	    명 : 이부영");
	//						str.push("소 재 지 : 경기 수원 영통 하 25");
	//						str.push("업	    태 : 서비스업");
	//						str.push("종	    목 : 공공시설물운영");
	//						str.push(s.br);
	//						str.push("거래일자 : [etDate]");
	//						str.push(s.br);
	//						str.push("면세금액 : [noTaxAmt] 원");
	//						str.push("과세금액 : [netAmt] 원");
	//						str.push("부 가 세 : [vatAmt] 원");
	//						str.push("합    계 : [totAmt] 원");
	//						str.push(s.br);
	//						str.push("고유번호 : [cardNo]");
	//						str.push("승인번호 : [appNo]");

						var s = Ez.s;

						var pad = 15;

						for(var i=0; i<2; i++){

							template = template.replace("[title]", !payment.cardName || payment.cardName.indexOf("자진") == -1 ? "현금영수증" : payment.cardName);

							template = template.replace("[etDate]", payment.etDate.date().print("yyyy년mm월dd일"));
							template = template.replace("[noTaxAmt]", s.lpad(payment.noTaxAmt.money()+"", " ", pad));
							template = template.replace("[netAmt]", s.lpad(payment.netAmt.money()+"", " ", pad));
							template = template.replace("[vatAmt]", s.lpad(payment.vatAmt.money()+"", " ", pad));
							template = template.replace("[totAmt]", s.lpad((payment.netAmt+payment.vatAmt+payment.noTaxAmt).money()+"", " ", pad));
							template = template.replace("[cardNo]", payment.cardNo);
							template = template.replace("[appNo]", payment.appNo);
	//							str.push("   고인명:[deadName]([binsoName])");
							template = template.replace("[deadName]", funeral.thedead.deadName);
							template = template.replace("[binsoName]", funeral.binso.binsoName);
						}

						template = fnObj.template.deleteKeywords(template);

						template = template.replace(/</g, "[");
						template = template.replace(/>/g, "]");

						return template;
					},
					drawCardStmt: function(funeral, payment){

						var template = fnObj.template.cardStmt();

						var s = Ez.s;
						var str = [];

//	str.push(s.font.size("21")+"[cardName]");
//	str.push(s.font.size("01")+"[cardNo]");
// str.push("가맹번호 : [aquirer]");
// str.push("거래일자 : [etDate]");
// str.push("거래구분 : [halbu]");
// str.push("단말번호 : [tid]");
//	str.push("면세금액 : [noTaxAmt] 원");
//	str.push("과세금액 : [netAmt] 원");
//	str.push("부 가 세 : [vatAmt] 원");
//	str.push("합    계 : [totAmt] 원");
//	str.push("승인번호 : [appNo]");
//	str.push("거래번호 : [buyNo]");
//	str.push("매 입 사 : [cardName]");
//	str.push("알    림 : [notice]");
//	str.push(s.br);
//	str.push("서명 :  ______________________");
//	str.push("   고인명:[deadName]([binsoName])");

						var pad = 15;

						for(var i=0; i<3; i++){

							if(payment.paymentCard){
								template = template.replace("[aquirer]", payment.paymentCard.aquirer);
								template = template.replace("[halbu]", payment.paymentCard.halbu == "00" ? "일시불" : "할부");
								template = template.replace("[buyNo]", payment.paymentCard.buyNo);
								template = template.replace("[cardName]", payment.paymentCard.cardName);
								template = template.replace("[notice]", payment.paymentCard.notice);
							}

							template = template.replace("[cardName]", payment.cardName);
							template = template.replace("[cardNo]", payment.cardNo);
							template = template.replace("[etDate]", payment.etDate.date().print("yyyy년mm월dd일"));
							template = template.replace("[tid]", payment.tid);
							template = template.replace("[noTaxAmt]", s.lpad(payment.noTaxAmt.money()+"", " ", pad));
							template = template.replace("[netAmt]", s.lpad(payment.netAmt.money()+"", " ", pad));
							template = template.replace("[vatAmt]", s.lpad(payment.vatAmt.money()+"", " ", pad));
							template = template.replace("[totAmt]", s.lpad(payment.cardAmt.money()+"", " ", pad));
							template = template.replace("[appNo]", payment.appNo);
							template = template.replace("[deadName]", funeral.thedead.deadName);
							template = template.replace("[binsoName]", funeral.binso.binsoName);
						}

						template = fnObj.template.deleteKeywords(template);

						template = template.replace(/</g, "[");
						template = template.replace(/>/g, "]");

						return template;
					}
				},
				print: function(){
					var item = fnObj.grid.target.getSelectedItem();
					if(item.error){
						alert("고인을 선택 후 출력버튼을 클릭해 주세요.");
						return;
					}
					app.ajax({
                        type: "get",
                        url: "/FUNE5080/funeral",
                        data: "customerNo="+item.item.customerNo
                    },
                    function(res) {
                        if (res.error) {
                            alert(res.error.message);
                        } else {

                        	var funeral = res.map.funeral;

                        	var payments = [];

                        	switch ($("#receipt").bindSelectGetValue().optionValue) {
							case "":
                        		payments = funeral.payment;
								break;
							case "0":
	                        	$.each(funeral.payment, function(i, o){
	                        		if(o.cflg != 1){
	                        			payments.push(o);
	                        		}
	                        	});
								break;
							case "1":
	                        	$.each(funeral.payment, function(i, o){
	                        		if(o.cflg != 1){
	                        			payments.push(o);
	                        		}
	                        	});
								break;
							default:
								break;
							}

                        	var pr = function(){
                        		var pay = payments.shift();
                            	if(!pay){
                            		return;
                            	}
		                		var receiptWin = window.open(`/receipt/payment/fune?customerNo=\${funeral.customerNo}&deadId=\${pay.deadId}&tid=\${pay.tid}&seq=\${pay.seq}&auto=N`, "_blank", "width=310,height=600");
                        	}

                        	pr();
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
                                    	{label:"조회구분", labelWidth:"", type:"selectBox", width:"150", key:"searchKind", addClass:"", valueBoxStyle:"", value:"close", options:[],


	                                    	AXBind: {
	                                            type: "select", config: {

	                                                reserveKeys: {
	                                                      options: "list",
	                                                      optionValue: "code",
	                                                      optionText: "name"
	                                                   },

	                                              ajaxUrl: "/FUNE5080/search-kind-options",
	                                              ajaxPars: null,
	                                              setValue: "",
	                                              alwaysOnChange: true,
	                                              onChange: function() {
	                                            	  switch (this.value) {
														case '1':
															$("#"+fnObj.search.target.getItemId("deadName")).prop("disabled", true);
															$("#"+fnObj.search.target.getItemId("balinDate")).prop("disabled", true);
															break;
														case '2':
															$("#"+fnObj.search.target.getItemId("deadName")).prop("disabled", false);
															$("#"+fnObj.search.target.getItemId("balinDate")).prop("disabled", false);
															break;

														default:
															break;
														}
														fnObj.grid.target.setData({list: []});
	                                              }
	                                            }
	                                        }
										},
                               		]
                                },

                                {display:true, addClass:"", style:"", list:[
										{label:"고인명", labelWidth:"", type:"inputText", width:"100", key:"deadName", addClass:"", valueBoxStyle:"", value:"",
										    onChange: function(changedValue){
// 										    	_this.submit();
										    }
										}
	                            	]
	                            },

	                            {display:true, addClass:"", style:"", list:[

									{label:"발인일자", labelWidth:"", type:"inputText", width:"110", key:"balinDate", addClass:"", valueBoxStyle:"", value:"",
										onChange:function(){
											_this.submit();
										},
										AXBind:{
											type:"date", config:{
												align:"center", valign:"top",
												onChange:function(){
// 													_this.submit();
												}
											}
										}
									}

	                                ]

	                            }



                            	]
                        	});

                        setTimeout(function(){
                        	$("#"+fnObj.search.target.getItemId("balinDate")).val("");
                       		$("#"+fnObj.search.target.getItemId("deadName")).bind("keyup", function(e){
                       			if(this.value == ""){
                       				$("#"+fnObj.search.target.getItemId("balinDate")).prop("disabled", false);
                       			}else{
                       				$("#"+fnObj.search.target.getItemId("balinDate")).prop("disabled", true);
                       			}
                       			if(e.keyCode==13){
                       				_this.submit();
                       			}
                       		});
                       		$("#"+fnObj.search.target.getItemId("balinDate")).bind("keyup", function(e){
                       			if(this.value == ""){
                       				$("#"+fnObj.search.target.getItemId("deadName")).prop("disabled", false);
                       			}else{
                       				$("#"+fnObj.search.target.getItemId("deadName")).prop("disabled", true);
                       			}
                       			if(e.keyCode==13){
                       				_this.submit();
                       			}
                       		});
                        }, 300);


                    },
                    submit: function(){
                        var pars = this.target.getParam();
                        fnObj.grid.setPage(fnObj.grid.pageNo, pars);
                    }
                },

                grid: {
                    pageNo: 1,
                    target: new AXGrid(),
                    params:null,
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
                                {key:"customerNo", label:"고객번호", width:"100", align:"left"},
                                {key:"deadName", label:"고인명", width:"100"},
                                {key:"deadSex", label:"성별", width:"100", align:"center", formatter: function(){
                                	return Common.grid.codeFormatter("deadSex", this.value);
                                }},
                                {key:"deadAge", label:"나이", width:"100"},
                                {key:"binsoName", label:"빈소", width:"100", align:"center"}
                            ],
                            body : {//test
                                onclick: function(){
                                    // fnObj.form.setJSON(this.item);
                                    var info;

                                    info = "| 고인정보 | "+ this.item.customerNo + " | " + this.item.deadName + " | " + this.item.binsoName + " | " + $("#"+fnObj.search.target.getItemId("balinDate")).val();
                                    $("#deadInfo").html(info);

                                    var cashKind = $("#receipt").bindSelectGetValue().optionValue;
                                    switch (cashKind) {
									case "0":
										cashKind = "0";
										break;
									case "1":
										cashKind = "1";
										break;
									default:
										cashKind = encodeURI("%");
										break;
									}
                                    var params = "customerNo="+this.item.customerNo+"&cashKind="+cashKind;
                                    fnObj.grid.params = "customerNo="+this.item.customerNo;
                                    fnObj.pageStart.params = "customerNo="+this.item.customerNo+"&cashKind="+cashKind;
                                    fnObj.report(params);
                                }
                            }
                            /* page: {
                                display: true,
                                paging: true,
                                onchange: function(pageNo){
                                    _this.setPage(pageNo);
                                }
                            } */
                        });
                    },
                    add:function(){
                        this.target.pushList({});
                        this.target.setFocus(this.target.list.length-1);
                    },
                    del:function(){
                        var _target = this.target,
                                nextFn = function() {
                                    _target.removeListIndex(checkedList);
                                    toast.push("삭제 되었습니다.");
                                };

                        var checkedList = _target.getCheckedListWithIndex(0);// colSeq
                        if(checkedList.length == 0){
                            alert("선택된 목록이 없습니다. 삭제하시려는 목록을 체크하세요");
                            return;
                        }
                        var dto_list = [];
                        $.each(checkedList, function(){
                            if(this.item._CUD != "C"){
                                dto_list.push("key=" + this.item.key); // ajax delete 요청 목록 수집
                            }
                        });

                        if(dto_list.length == 0) {
                            nextFn(); // 스크립트로 목록 제거
                        }
                        else {
                            app.ajax({
                                type: "DELETE",
                                url: "/api/v1/samples/parent",
                                data: dto_list.join("&")
                            },
                            function(res) {
                                if (res.error) {
                                    alert(res.error.message);
                                } else {
                                    nextFn(); // 스크립트로 목록 제거
                                }
                            });
                        }
                    },
                    setPage: function(pageNo, searchParams){

                    	var _target = this.target;
                        this.pageNo = pageNo;

                        var searchKind = Common.search.getValue(fnObj.search.target, "searchKind");

                        if(searchKind == '2'
                    			&& $("#"+fnObj.search.target.getItemId("deadName")).val() == ''
								&& $("#"+fnObj.search.target.getItemId("balinDate")).val() == ''){
                    		alert("고인명 또는 발인일자를 입력해 주세요.");
                    		return;
                    	}

                        var url = "/FUNE5080/dead";
                        if(searchKind == '1'){
                        	url = "/FUNE5080/assignedDead";
                        }

                        app.ajax({
                            type: "GET",
                            url: url,
                            data: "dummy="+ axf.timekey() +"&pageNumber=" + (pageNo-1) + "&pageSize=50&" + (searchParams||fnObj.search.target.getParam())
                        }, function(res){
                            if(res.error){
                                alert(res.error.message);
                            }
                            else
                            {
                                var gridData = {
                                    list: res.list
                                    /* page:{
                                        pageNo: res.page.currentPage.number()+1,
                                        pageSize: res.page.pageSize,
                                        pageCount: res.page.totalPages,
                                        listCount: res.page.totalElements
                                    } */
                                };

                                _target.setData(gridData);
                            }
                        });
                    }
                },

                form: {
                    target: $('#form-info'),
                    validate_target: new AXValidator(),
                    bind: function() {
                        var _this = this;

                        this.validate_target.setConfig({
                            targetFormName : "form-info"
                        });
                        app.ajax({
                        	url:"/FUNE5080/receipt",
                        	type:"POST"

                        }, function(res){
                        	var list=res.list;
                        	var options = "";

                        	options+="<option value='"+""+"'>"+"전체"+"</option>";
                        	for(var i=0; i<list.length; i++){
                        		options+="<option value='"+list[i].code+"'>"+list[i].name+"</option>";
                        	}

                        	$("#receipt").html(options);
                        });

                        setTimeout(function(){
                            $("#receipt").bindSelect({
                                onChange: function(){
                                	if(fnObj.grid.params == null)
                                		return;

                                	var cashKind = $("#receipt").bindSelectGetValue().optionValue;
                                    switch (cashKind) {
									case "0":
										cashKind = "0";
										break;
									case "1":
										cashKind = "1";
										break;
									default:
										cashKind = encodeURI("%");
										break;
									}
                                	var params = fnObj.grid.params+"&cashKind="+cashKind;
  									fnObj.report(params);
                                }
                            });
                        }, 1000);

                    },
                    setJSON: function(item) {
                        var _this = this;

                        // 수정시 입력 방지 처리 필드 처리
                        $('#info-key').attr("readonly", "readonly");

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
                        $('#info-key').removeAttr("readonly");
                    }
                }, // form

                report: function(params){
                	var path = "/reports/changwon/fune/FUNE5081";
                	var output = "pdf";
                	var frameId = "reportDisplay";
                	Common.report.embedded(path, output, params, frameId);
                	toast.push("로딩중입니다.");
                },

                excel: function(params){
                	var path = "/reports/changwon/fune/FUNE5081";
                	var output = "excel";
                	Common.report.go(path, output, params);
                	toast.push("로딩중입니다.");
                }


            };
        </script>
    </ax:div>
</ax:layout>