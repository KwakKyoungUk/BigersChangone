/*****************************************************************************
 * 프로그램명  : SUIP1020Controller.java
 * 설     명  : 수입 관리 > 현금 송금 관리(기간) 처리 컨트롤러
 * 참고  사항  : 없음
 *****************************************************************************
 * Date       Author  Version Description
 * ---------- ------- ------- -----------------------------------------------
 * 2017.11.22  KYM    1.0     초기작성
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
public class SUIP1020Controller extends BaseController{

	@Autowired
	private PaymentService paymentService;
	@Autowired
	private SaleStmtService saleStmtService;	
	@Inject
	private BasicCodeService basicCodeService;
	
	
	/**
	 * 베이직 코드 취득
	 */
	@RequestMapping(value="/SUIP1020/basic-select-options", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getBasicSelectOptionList(){
		List<BasicCode> list = basicCodeService.findByBasicCd("401");
		return CommonListResponseParams.ListResponse.of(list);
	}
	/**
	 * 현금 송금 관리 조회 목록 취득
	 * @param request Request객체
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "현금 송금 관리 조회", notes = "현금 송금 관리 조회")
	@RequestMapping(value="/SUIP1020/cashSend" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public List<Object[]> getCashSendList(@RequestParam Map<String, String> requestBody) throws Exception{		
		//개별판매
		List<Object[]> cashSendListSaleStmt = saleStmtService.findCashSendListSaleStmt(requestBody);
		//빈소판매
		List<Object[]> cashSendListPayment = paymentService.findCashSendListPayment(requestBody);
		
		List<Object[]> res 					= new ArrayList<Object[]>();
		res.addAll(cashSendListSaleStmt);
		res.addAll(cashSendListPayment);
		
		return res;
	}	
}
