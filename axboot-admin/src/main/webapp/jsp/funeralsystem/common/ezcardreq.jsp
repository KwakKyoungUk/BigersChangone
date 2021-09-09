<%@ page contentType="text/html; charset=UTF-8" %>

<script type="text/javascript" src="/static/plugins/jquery/jquery.min.1.4.js"></script>
<script type="text/javascript" src="/static/js/common/ezcard.js?V=1"></script>
<script type="text/javascript">
function request(gubun, amount, yymmdd, apprNum, callback, halbu){

	if(gubun == "D1"){
		Ez.reqCancelCard(amount, halbu, yymmdd, apprNum, callback);
	}else{
		Ez.reqCancelCash(amount, yymmdd, apprNum, callback);
	}

}


function requestTax(gubun, amount, yymmdd, apprNum, vat, callback, halbu){

	if(gubun == "D1"){
		Ez.reqCancelTaxCard(amount, halbu, yymmdd, apprNum, vat, callback);
	}else{
		if(gubun == "B1"){
			Ez.reqCancelTaxCash(amount, yymmdd, apprNum, vat, callback);
		}else{
			Ez.reqJajinCancelTaxCash(amount, yymmdd, apprNum, vat, callback);
		}
	}

}

function requestReturnCancelTax(gubun, amount, yymmdd, apprNum, vat, callback, halbu, cashGubun){

	if(gubun == "D1"){
		Ez.reqReturnCancelTaxCard(amount, halbu, yymmdd, apprNum, vat, callback);
	}else{
		if(gubun == "B1"){
			Ez.reqCancelTaxCash(amount, yymmdd, apprNum, vat, callback, cashGubun);
		}else{
			Ez.reqJajinCancelTaxCash(amount, yymmdd, apprNum, vat, callback);
		}
	}

}
</script>