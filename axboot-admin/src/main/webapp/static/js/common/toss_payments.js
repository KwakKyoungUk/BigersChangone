
var Pay = {
		URL: "http://127.0.0.1:10002",
		BUSINESSNUM: "609-82-076",
		req: function(reqObj, callback){
			var reqStr = $.param(reqObj)
			var _this = this

			$.ajax({
		           type:"POST",
		           url: this.URL,
		           data: reqStr,
		           dataType:"TEXT",
		           success : function(text) {

		        	   var res = JSON.parse(text.replace(/\\/gi, "\\\\"))

		        	   $.extend( reqObj, res );

		        	   // 결제응답 데이터 저장
		        	   var tossReqResData = {
		        			   toss: reqObj, ezCard: _this.toEzRes(reqObj, res)
		        	   }

		        	   if(res.Respcode != "0000"){
		        		   tossReqResData.ezCard.SUC = ""
		        		   callback(tossReqResData)
		        		   return
		        	   }


		        	   callback(tossReqResData)

		        	   var payData = {toss: {}, ezCard: {}}
		        	   for(var key in tossReqResData.toss){
		        		   payData.toss[key.toLowerCase()] = tossReqResData.toss[key]
		        	   }
		        	   for(var key in tossReqResData.ezCard){
		        		   payData.ezCard[key.toLowerCase()] = tossReqResData.ezCard[key]
		        	   }

		        	   $.ajax({
				           type:"PUT",
				           url: "/receipt/payData",
				           contentType : "application/json; charset=utf-8",
				           data: JSON.stringify(payData),
				           dataType:"JSON", // 옵션이므로 JSON으로 받을게 아니면 안써도 됨
				           success : function(res2) {

				           },
				           complete : function(data) {

				           },
				           error : function(xhr, status, error) {
				           }
					   });

		           },
		           complete : function(data) {

		           },
		           error : function(xhr, status, error) {
		        	   alert("결제모듈을 확인해 주세요.")
		           }
		     });
		},
		codeMapping: {
			"S0": "D1",
			"41": "B1",
			"S1": "D2",
			"42": "B2"
		},
		toEzRes: function(req, res){

			if(req.LGD_CASHCARDNUM == "0100001234"){
				res.Cardno = "0100001234"
			}

			var ezCard = {
					SUC: "00",
					mkind: req.VAN_TRANTYPE,
					RQ01: this.codeMapping[req.VAN_TRANTYPE],
					RQ02: res.Mid, // 단말기번호
					RQ03: req.VAN_TRANTYPE[0]=='S' ? 'A':'@', // 카드입력구분
					RQ04: res.Cardno||'', // 카드번호
					RQ05: req.VAN_TRANTYPE[0]=='S' ? '****':'', // 유효기간
					RQ06: res.Halbu||'', // 할부개월
					RQ07: req.LGD_AMOUNT, //res.Tamt(현금에서는 이금액이 안나옴), // 금액
					RQ08: req.LGD_CASHRECEIPTUSE||'', // 현금영수증 거래용도
					RQ09: "", // 상품코드
					RQ10: req.VAN_AUTHNO, // 원승인번호
					RQ11: req.VAN_CAPDATE||'', // 원승인일자
					RQ12: "0", // 봉사료
					RQ13: req.LGD_VAT, // 부가세
					RQ14: req.LGD_OID, // 임시판매번호
					RQ15: req.LGD_PRODUCTINFO, // 웹전송메세지
					RQ16: "", // 단말구분코드
					RS01: "", // 거래제어코드
					RS02: "", // 정산INDX
					RS03: res.Tran_serial, // 거래일련번호
					RS04: "0000", // 응답코드
					RS05: res.Reqinst, // 매입사 코드
					RS06: "", // 매입 일련번호
					RS07: res.Trandate, // 승인일시
					RS08: res.Tran_serial, // 거래 고유번호
					RS09: res.Authno, // 승인 번호
					RS10: res.Cardgubun=="2" ? "1":"0", // 체크카드유무
					RS11: res.Financecode, // 발급사코드
					RS12: res.Financename, // 발급사명
					RS13: res.Merno, // 가맹점 번호
					RS14: "", // 매입사명
					RS15: "", // 화면제어코드
					RS16: req.Msg, // 화면표시
					RS17: req.Msg, // Notic
					RS18: "", // 전자서명 유무
					RS19: "", // 사업자번호
					RS20: ""  // 서명BMP 키
			}
			return ezCard
		},
		makeOID: function(){
			var ToDay = new Date();
			var Year = ToDay.getFullYear();
			var Month = ("0" + (ToDay.getMonth() + 1)).slice(-2);
			var Day = ("0" + ToDay.getDate()).slice(-2);
			var Hour = ("0" + ToDay.getHours()).slice(-2);
			var Minute = ("0" + ToDay.getMinutes()).slice(-2);
			var Seconds = ("0" + ToDay.getSeconds()).slice(-2);
			var MilliSeconds = ToDay.getMilliseconds();
			var RandomNum = Math.floor(Math.random() * 100);
			return Year + Month + Day + Hour + Minute + Seconds + MilliSeconds + RandomNum;
		},
		Appr: {
			card: function(amount, vat, install, callback){
				var _this = this

				var req = {
						VAN_TRANTYPE: "S0",			//신용카드 승인
						LGD_TXNAME: "CardAuthOfflinePos",
						LGD_REQTYPE: "APPR",
						LGD_OID: Pay.makeOID(),
						LGD_AMOUNT: amount,
						LGD_INSTALL: install,
						LGD_NOINT: 0,				// 무이자 할부 여부: 0-일반, 1-무이자
						LGD_PRODUCTINFO: "전자결제상품",
						LGD_TAXFREEAMOUNT: 0, // 면세금액
						LGD_VAT: vat,	// 부가세
						VAN_SFEEAMOUNT: 0	// 봉사료
				}

				Pay.req(req, callback)
			},
			/**
			 * cashGubun : 1 - 소득공제, 2 - 지출증빙
			 */
			cash: function(cashGubun, amount, vat, cashcardnum, callback){
				var _this = this

				var req = {
						VAN_TRANTYPE: "41",			//신용카드 승인
						LGD_TXNAME: "CardAuthOfflinePos",
						LGD_REQTYPE: "CASHAPPR",
						LGD_PAYTYPE: "SC0100",
						LGD_OID: Pay.makeOID(),
						LGD_AMOUNT: amount,
						LGD_CASHCARDNUM: cashcardnum,
						LGD_CASHRECEIPTUSE: cashGubun,
						LGD_PRODUCTINFO: "전자결제상품",
						LGD_CUSTOM_BUSINESSNUM: this.BUSINESSNUM,
						LGD_SEQNO: "001",
						LGD_TAXFREEAMOUNT: 0,
						LGD_VAT: vat,
						VAN_SFEEAMOUNT: 0
				}

				Pay.req(req, callback)

			},
			jajin: function(amount, vat, callback){
				this.cash("1", amount, vat, "0100001234", callback)
			}
		},
		Cancel: {
			card: function(amount, vat, install, tran_serial, capdate, appno, callback){
				var _this = this

				var req = {
						VAN_TRANTYPE: "S1",
						LGD_TXNAME: "CardAuthOfflinePos",
						LGD_REQTYPE: "CANCEL",
						LGD_AMOUNT: amount,
						LGD_INSTALL: install,
						LGD_TID: tran_serial,
						LGD_TAXFREEAMOUNT: 0,
						LGD_VAT: vat,
						VAN_SFEEAMOUNT: 0,
						VAN_CAPDATE: capdate,
						VAN_AUTHNO: appno
				}

				Pay.req(req, callback)
			},
			cash: function(cashGubun, amount, vat, cashcardnum, tran_serial, capdate, appno, callback){
				var _this = this

				var req = {
						LGD_TXNAME: "CardAuthOfflinePos",
						LGD_REQTYPE: "CASHCANCEL",
						LGD_PAYTYPE: "SC0100",
						LGD_AMOUNT: amount,
						LGD_CASHCARDNUM: cashcardnum,
						LGD_CASHRECEIPTUSE: cashGubun,
						LGD_TID: tran_serial,
						LGD_SEQNO: "001",
						LGD_TAXFREEAMOUNT: 0,
						LGD_VAT: vat,
						VAN_SFEEAMOUNT: 0,
						VAN_TRANTYPE: "42",
						VAN_CAPDATE: capdate,
						VAN_AUTHNO: appno
				}

				Pay.req(req, callback)
			}
		}
}