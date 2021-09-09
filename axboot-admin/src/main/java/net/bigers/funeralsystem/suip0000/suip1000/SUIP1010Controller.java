/*****************************************************************************
 * 프로그램명  : SUIP1010Controller.java
 * 설     명  : 수입 관리 > 현금 송금 관리 처리 컨트롤러
 * 참고  사항  : 없음
 *****************************************************************************
 * Date       Author  Version Description
 * ---------- ------- ------- -----------------------------------------------
 * 2017.11.14  KYM    1.0     초기작성
 *****************************************************************************/
package net.bigers.funeralsystem.suip0000.suip1000;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.wordnik.swagger.annotations.ApiOperation;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;

import net.bigers.funeralsystem.fune0000.domain.payment.PaymentService;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt.SaleStmtService;
import net.bigers.funeralsystem.fune0000.vto.SuipVTO;

@Controller
public class SUIP1010Controller extends BaseController{

	@Autowired
	private PaymentService paymentService;
	@Autowired
	private SaleStmtService saleStmtService;
	@Inject
	private BasicCodeService basicCodeService;


	/**
	 * 베이직 코드 취득
	 */
	@RequestMapping(value="/SUIP1010/basic-select-options", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getBasicSelectOptionList(String basic_code){
		List<BasicCode> list = basicCodeService.findByBasicCd(basic_code);
		return CommonListResponseParams.ListResponse.of(list);
	}

	/**
	 * 현금 송금 관리 조회 목록 취득
	 * @param request Request객체
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "현금 송금 관리 조회", notes = "현금 송금 관리 조회")
	@RequestMapping(value="/SUIP1010/cashSend" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public List<Object[]> getCashSendList(@RequestParam Map<String, String> requestBody) throws Exception{

		List<Object[]> res 					= new ArrayList<Object[]>();

		String cjob = requestBody.get("cjob");

		if("F".equals(cjob)){
			//개별판매
			List<Object[]> cashSendListSaleStmt = saleStmtService.findCashSendListSaleStmt(requestBody);
			//빈소판매
			List<Object[]> cashSendListPayment = paymentService.findCashSendListPayment(requestBody);

			res.addAll(cashSendListSaleStmt);
			res.addAll(cashSendListPayment);
		}else{
			//승화원
			List<Object[]> findCashSendListPaymentHEN = paymentService.findCashSendListPaymentHEN(requestBody);

			res.addAll(findCashSendListPaymentHEN);
		}

		return res;
	}

	/**
	 * 현금 송금 관리 송금처리
	 * @param SuipVTO
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = " 송금처리", notes = "송금처리")
	@RequestMapping(value="/SUIP1010/suipCash" , method= RequestMethod.POST, produces=APPLICATION_JSON )
	public ApiResponse updateIndatePaySale(@RequestBody SuipVTO suipVTO) throws Exception{
		paymentService.updateIndatePaySale(suipVTO);
		return ok();
	}

	/**
	 * 현금 송금 관리 송금취소
	 * @param SuipVTO
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = " 송금처리", notes = "송금처리")
	@RequestMapping(value="/SUIP1010/suipCashCancel" , method= RequestMethod.POST, produces=APPLICATION_JSON )
	public ApiResponse updateIndatePaySaleCancel(@RequestBody SuipVTO suipVTO) throws Exception{
		paymentService.updateIndatePaySaleCancel(suipVTO);
		return ok();
	}


}
