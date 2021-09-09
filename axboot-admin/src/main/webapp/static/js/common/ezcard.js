/**
 *
 */

var Ez = {

	URL_SCHEMA: "ezstart://"
	, URL: "http://127.0.0.1"

	, stringformat: function (text) {
		if (arguments.length <= 1) return text;

		for (var i = 0; i <= arguments.length - 2; i++) {
			text = text.replace(new RegExp("\\{" + i + "\\}", "gi"), arguments[i + 1]);
		}

		return text;
	}


	, run: function(){
		location.href = Ez.URL_SCHEMA;
	}

	, close: function(){
		var _this = this;
		var s = "CC^";
		$.ajax({
			url: _this.URL,
			dataType : "jsonp",
			type : "GET",
			jsonp : "callback",
			data : {"REQ": s},
			success: function(data){
				document.getElementById("recv").innerText= JSONtoString(data);
			}
		});
	}

	, reqObj : {
		keys : [
			"gubun"	// 전문구분
			, "cashGubun"	// 현금영수증용도
			, "amount"	// 금액
			, "install"	// 할부
			, "yymmdd"	// (취소시) 원승인일자
			, "apprNum"	// (취소시) 원승인번호
			, "code"	// 상품코드
			, "sellNum"	// 임시판매번호
			, "message"	// 웹전송메세지
			, "keyin"	// 키인허용
			, "multiTid"	// 멀티사업자 단말기ID
			, "timeout"	// 타임아웃
			, "vat"	// 부가세
			, "addfield"	// 추가필드
			, "handle"	// 수신핸들값
			, "catgubun"	// 단말기구분
			, "discount"	// 할인/적립구분
			, "passwd"	// 비밀번호
			, "extend"	// 거래확장옵션
			, "serialno"	// (취소시) 거래고유번호
//			, "dongflag"	// 동글Flag

		]
		, initObj: function(){
			var res = {};
			$.each(this.keys, function(i, o){
				res[o] = "";
			})
			return res;
		}
		, getObj: function(req){
			var obj = this.initObj();
			return $.extend(obj, req);
		}
		, serialize: function(obj){
			var res = [];
			$.each(this.keys, function(i, key){
				res.push(obj[key]);
			});
			return res.join("^");
		}
	}

	, createCreditStr: function(amount, halbu, isVat, vat){

		var vat;
		if(isVat){
			vat = "A";
		}else{
			if(vat){
				vat = "M"+vat;
			}else{
				vat = "F"
			}
		}

		var reqCreditObj = this.reqObj.getObj({
			gubun: "D1"
			, amount: amount
			, install: halbu
			, sellNum: "suwon"
			, timeout: "30"
			, vat: vat
		});
		return this.reqObj.serialize(reqCreditObj);
	}

	, createCashStr: function(amount, cashGubun, isVat, vat){

		var vat;
		if(isVat){
			vat = "A";
		}else{
			if(vat){
				vat = "M"+vat;
			}else{
				vat = "F"
			}
		}

		var reqCashObj = this.reqObj.getObj({
			gubun: "B1"
			, cashGubun: cashGubun
			, amount: amount
			, install: "00"
			, sellNum: "suwon"
			, timeout: "30"
			, vat: vat
		});
		return this.reqObj.serialize(reqCashObj);
	}

	, createCancelStr: function(gubun, amount, halbu, yymmdd, apprNum, isVat, vat, cashGubun){

		var vat;
		if(isVat){
			vat = "A";
		}else{
			if(vat){
				vat = "M"+vat;
			}else{
				vat = "F"
			}
		}

		var obj = {
				gubun: gubun
				, amount: amount
				, yymmdd: yymmdd
				, apprNum: apprNum
				, install: "00"
				, timeout: "30"
				, vat: vat
				, install: halbu
			};
		if(cashGubun){
			obj.cashGubun = cashGubun;
		}

		var reqCashObj = this.reqObj.getObj(obj);
		return this.reqObj.serialize(reqCashObj);
	}

	, createCancelCashStr: function(amount, yymmdd, apprNum, isVat, vat, cashGubun){
		return this.createCancelStr("B2", amount, "00", yymmdd, apprNum, isVat, vat, cashGubun);
	}

	, createJajinCancelCashStr: function(amount, yymmdd, apprNum, isVat, vat){
		return this.createCancelStr("B4", amount, "00", yymmdd, apprNum, isVat, vat);
	}

	, createCancelCardStr: function(amount, halbu, yymmdd, apprNum, isVat, vat){
		return this.createCancelStr("D2", amount, halbu, yymmdd, apprNum, isVat, vat);
	}

	, createReturnCancelCardStr: function(amount, halbu, yymmdd, apprNum, isVat, vat){
		return this.createCancelStr("D4", amount, halbu, yymmdd, apprNum, isVat, vat);
	}

	, ezRequest: function(str, pcallback, method){
		var _this = this;
//		$.ajaxSetup({
//		    scriptCharset: "euc-kr",
//		    contentType: "application/jsonp; charset=euc-kr"
//		});
		$.ajax({
			url: _this.URL,
			type: method || "GET",
			dataType : "jsonp",
			jsonp : "callback",
			data : {
				"REQ": _this.stringformat(encodeURI(str))
//				, "SEED": _this.stringformat("0700081 404154457717160204154457")
			},
			success: function(data){
				pcallback(data);

				var d = {};
				for(var key in data){
					d[key.toLowerCase()] = data[key];
				}

				$.ajax({
					url: "/ezCard"
					, type: "POST"
					, contentType: "application/json"
					, data: JSON.stringify(d)
					, success: function(result){
						console.log(result);
					}
					, error:function(e){
						console.log(e.responseText);
			        }
				});
			}
		});
	}

	, reqCredit: function(amount, halbu, callback){
		Ez.ezRequest(Ez.createCreditStr(amount+"", this.s.lpad(halbu, "0", 2), true), callback);
	}

	, reqCreditTax: function(amount, halbu, vat, callback){
		Ez.ezRequest(Ez.createCreditStr(amount+"", this.s.lpad(halbu, "0", 2), false, vat), callback);
	}

	, reqCreditNoTax: function(amount, halbu, callback){
		Ez.ezRequest(Ez.createCreditStr(amount+"", this.s.lpad(halbu, "0", 2), false), callback);
	}

	, reqCashPerson: function(amount, callback){
		Ez.ezRequest(Ez.createCashStr(amount+"", "00", true), callback);
	}

	, reqCashJajin: function(amount, callback){
		Ez.ezRequest(Ez.createCashStr(amount+"", "00", true).replace("B1", "B3"), callback);
	}

	, reqCashPersonTax: function(amount, vat, callback){
		Ez.ezRequest(Ez.createCashStr(amount+"", "00", false, vat), callback);
	}

	, reqCashJajinTax: function(amount, vat, callback){
		Ez.ezRequest(Ez.createCashStr(amount+"", "00", false, vat).replace("B1", "B3"), callback);
	}

	, reqCashJajinNoTax: function(amount, callback){
		Ez.ezRequest(Ez.createCashStr(amount+"", "00", false).replace("B1", "B3"), callback);
	}

	, reqCashPersonNoTax: function(amount, callback){
		Ez.ezRequest(Ez.createCashStr(amount+"", "00", false), callback);
	}

	, reqCashCompany: function(amount, callback){
		Ez.ezRequest(Ez.createCashStr(amount+"", "01", true), callback);
	}

	, reqCashCompanyTax: function(amount, vat, callback){
		Ez.ezRequest(Ez.createCashStr(amount+"", "01", false, vat), callback);
	}

	, reqCashCompanyNoTax: function(amount, callback){
		Ez.ezRequest(Ez.createCashStr(amount+"", "01", false), callback);
	}

	/**
	 * amount: 금액
	 * yymmdd: 거래일(171024)
	 * apprNum: 승인번호
	 */
	, reqCancelCash: function(amount, yymmdd, apprNum, callback){
		Ez.ezRequest(Ez.createCancelCashStr(amount, yymmdd, apprNum, true), callback);
	}
	, reqJajinCancelCash: function(amount, yymmdd, apprNum, callback){
		Ez.ezRequest(Ez.createJajinCancelCashStr(amount, yymmdd, apprNum, true), callback);
	}

	/**
	 * amount: 금액
	 * yymmdd: 거래일(171024)
	 * apprNum: 승인번호
	 */
	, reqCancelCard: function(amount, halbu, yymmdd, apprNum, callback){
		Ez.ezRequest(Ez.createCancelCardStr(amount, halbu, yymmdd, apprNum, true), callback);
	}

	/**
	 * amount: 금액
	 * yymmdd: 거래일(171024)
	 * apprNum: 승인번호
	 */
	, reqReturnCancelCard: function(amount, halbu, yymmdd, apprNum, callback){
		Ez.ezRequest(Ez.createReturnCancelCardStr(amount, halbu, yymmdd, apprNum, true), callback);
	}

	/**
	 * amount: 금액
	 * yymmdd: 거래일(171024)
	 * apprNum: 승인번호
	 * vat: 부가세
	 */
	, reqCancelTaxCash: function(amount, yymmdd, apprNum, vat, callback, cashGubun){
		Ez.ezRequest(Ez.createCancelCashStr(amount, yymmdd, apprNum, false, vat, cashGubun), callback);
	}

	, reqJajinCancelTaxCash: function(amount, yymmdd, apprNum, vat, callback){
		Ez.ezRequest(Ez.createJajinCancelCashStr(amount, yymmdd, apprNum, false, vat), callback);
	}

	/**
	 * amount: 금액
	 * yymmdd: 거래일(171024)
	 * apprNum: 승인번호
	 * vat: 부가세
	 */
	, reqCancelTaxCard: function(amount, halbu, yymmdd, apprNum, vat, callback){
		Ez.ezRequest(Ez.createCancelCardStr(amount, halbu, yymmdd, apprNum, false, vat), callback);
	}

	/**
	 * amount: 금액
	 * yymmdd: 거래일(171024)
	 * apprNum: 승인번호
	 * vat: 부가세
	 */
	, reqReturnCancelTaxCard: function(amount, halbu, yymmdd, apprNum, vat, callback){
		Ez.ezRequest(Ez.createReturnCancelCardStr(amount, halbu, yymmdd, apprNum, false, vat), callback);
	}

	, isSuccess: function(data){
		return data.RS04 == '0000';
	}

	, s: {

		start: "EP"

		, br: eval('"'+"\\x0D"+'"') + eval('"'+"\\x0A"+'"')

		, cutting: eval('"'+"\\x1B"+'"') + "i"

		, align: {
			center: eval('"'+"\\x1B"+'"') + eval('"'+"\\x61"+'"') + eval('"'+"\\x01"+'"')
			, right: eval('"'+"\\x1B"+'"') + eval('"'+"\\x61"+'"') + eval('"'+"\\x02"+'"')
			, left: eval('"'+"\\x1B"+'"') + eval('"'+"\\x61"+'"') + eval('"'+"\\x03"+'"')
		}

		, font: {
			size: function(size16){
				return eval('"'+"\\x1B"+'"') + eval('"'+"\\x21"+'"') + eval('"'+"\\x"+size16+'"')
			}
		}

		, lpad : function(originalstr, strToPad , length) {
			var cnt = 0;
			$.each((originalstr+"").split(""), function(i, o){
				if(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/.test(o)){
					cnt++;
				}
			})
		    while (originalstr.length < length-cnt)
		        originalstr = strToPad + originalstr;
		    return originalstr;
		}
		, rpad : function(originalstr, strToPad , length) {
			var cnt = 0;
			$.each((originalstr+"").split(""), function(i, o){
				if(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/.test(o)){
					cnt++;
				}
			})
			while (originalstr.length < length-cnt)
				originalstr =  originalstr+strToPad;
			return originalstr;
		}
	}

	, samplePrint: function(){
		var s = this.s.start
		//정렬(1B 61) 01 중앙
		s = s + this.s.align.center
		//폰트크기(1B 21) 01
		s = s + this.s.font.size("01") + "    [RECEIPT]     " + this.s.br;
		//정렬(1B 61) 03 왼쪽
		s = s + this.s.align.left + this.s.br;
		s = s + this.s.br;
		s = s + "  SALE DATE  : 2016-01-05  14:12:43 " + this.s.br;
		s = s + "  CASHIER    : 박한결" + this.s.br;
		s = s + "  NO         : 123456789" + this.s.br;
		s = s + this.s.br;
		s = s + "  ========================================" + this.s.br;
		s = s + this.s.br;
		//폰트크기(1B 21) 11
		s = s + this.s.font.size("11") + "     CREDIT CARD     " + this.s.font.size("01");
		s = s + this.s.br;
		s = s + this.s.br;
		s = s + this.s.br;
		s = s + "  CARD NAME : 신한프리미엄" + this.s.br;
		s = s + "  CARD NO   : 465887**********" + this.s.br;
		s = s + "  EXPIRY    : ****       DIV : 00" + this.s.br;
		s = s + this.s.br;
		s = s + "  NET AMT   : 913" + this.s.br;
		s = s + "  VAT AMT   : 91" + this.s.br;
		s = s + "  TOTAL     : 1,004" + this.s.br;
		s = s + this.s.br;
		s = s + "  APPROVAL DATE : 16년 03월 21일 16:01:43" + this.s.br;
		s = s + "  APPROVAL      : 28244646" + this.s.br;
		s = s + "  ACQUIRER      : 신한카드" + this.s.br;
		s = s + "  MERCHANT      : 00404145" + this.s.br;
		s = s + "  BILL          : 0700081" + this.s.br;
		s = s + "  NOTICE        : " + this.s.br;
		s = s + this.s.br;
		s = s + this.s.br;
		s = s + this.s.br;
		s = s + this.s.br;
		//(1B i ) 는 cutting
		s = s + this.s.cutting + this.s.br;

		this.print(s, function(data){
			console.log(data);
		});
	}

	, print: function(str, callback, seed){

		var _this = this;
		var data = {
				"REQ": _this.stringformat(encodeURI(str))
		};
		if(seed){
			data.SEED = _this.stringformat(seed)
		}
		$.ajaxSetup({'cache':true});
		$.ajax({
			url: _this.URL,
			type: "POST",
			dataType : "jsonp",
			jsonp : "callback",
			data : {
				"REQ": _this.stringformat(encodeURI("FR^^^^^^^^^^^^^^^^^^^^"))
			},
			success: function(){
				$.ajax({
					url: _this.URL,
					type: "POST",
					dataType : "jsonp",
					jsonp : "callback",
					data : data,
					success: callback
				});
			}
		});

	}
}

