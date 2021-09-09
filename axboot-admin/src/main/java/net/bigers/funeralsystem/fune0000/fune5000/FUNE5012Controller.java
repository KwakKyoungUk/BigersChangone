package net.bigers.funeralsystem.fune0000.fune5000;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.fune0000.domain.funeral.FuneralService;
import net.bigers.funeralsystem.fune0000.domain.payment.Payment;
import net.bigers.funeralsystem.fune0000.domain.payment.PaymentId;
import net.bigers.funeralsystem.fune0000.domain.payment.PaymentService;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt.SaleStmtService;
import net.bigers.funeralsystem.lib.util.MapUtils;

@Controller
public class FUNE5012Controller extends BaseController {

	@Autowired
	private SaleStmtService saleStmtService;

	@Autowired
	private PaymentService paymentService;

	@Autowired
	private FuneralService funeralService;

	@ApiOperation(value = "전표", notes = "전표")
	@RequestMapping(value="/FUNE5012/saleStmt" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse getSaleStmt(String customerNo) throws Exception{

		return ListResponse.of(this.saleStmtService.findByCustomerNo(customerNo));
	}

	@ApiOperation(value = "결제", notes = "결제")
	@RequestMapping(value="/FUNE5012/payment" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse getPayment(String customerNo) throws Exception{

		return ListResponse.of(this.paymentService.findByCustomerNo(customerNo));
	}

	@ApiOperation(value = "결제정보 저장", notes = "결제정보 저장")
	@RequestMapping(value="/FUNE5012/payment" , method= RequestMethod.POST, produces=APPLICATION_JSON )
	public MapResponse postPayment(String customerNo, @RequestBody Payment payment) throws Exception{
		Map<String, Object> res = MapUtils.getMap("payment", this.paymentService.savePayment(customerNo, payment));
		res.put("funeral", this.funeralService.findOne(customerNo));
		return MapResponse.of(res);
	}

	@ApiOperation(value = "승인취소", notes = "승인취소")
	@RequestMapping(value="/FUNE5012/payment/cancel" , method= RequestMethod.POST, produces=APPLICATION_JSON )
	public MapResponse putPaymentCancel(String customerNo, Integer deadId, String tid, Integer seq, @RequestBody Payment payment) throws Exception{

		Map<String, Object> res = MapUtils.getMap("payment", this.paymentService.saveCancelPayment(customerNo, PaymentId.of(deadId, tid, seq), payment));
		res.put("funeral", this.funeralService.findOne(customerNo));

		return MapResponse.of(res);
	}

}
