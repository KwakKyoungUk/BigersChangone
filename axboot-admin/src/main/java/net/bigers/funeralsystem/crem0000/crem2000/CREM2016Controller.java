package net.bigers.funeralsystem.crem0000.crem2000;

import java.util.Arrays;
import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.crem0000.domain.hwacremation.HwaCremation;
import net.bigers.funeralsystem.crem0000.domain.hwacremation.HwaCremationId;
import net.bigers.funeralsystem.crem0000.domain.hwacremation.HwaCremationService;
import net.bigers.funeralsystem.fune0000.domain.funeral.Part;
import net.bigers.funeralsystem.fune0000.domain.payment.Payment;
import net.bigers.funeralsystem.fune0000.domain.payment.PaymentId;
import net.bigers.funeralsystem.fune0000.domain.payment.PaymentService;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt.SaleStmtService;
import net.bigers.funeralsystem.lib.util.MapUtils;

@Controller
public class CREM2016Controller extends BaseController {

	@Autowired
	private SaleStmtService saleStmtService;

	@Autowired
	private PaymentService paymentService;

	@Autowired
	private HwaCremationService hwaCremationService;

	@RequestMapping(value="/CREM2016/saleStmt", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public ListResponse getSaleStmt(
			@DateTimeFormat(pattern="yyyy-MM-dd") Date cremDate
			, Integer cremSeq
			) throws Exception{
		return ListResponse.of(this.hwaCremationService.getSaleStmt(HwaCremationId.of(cremDate, cremSeq)));
	}

	@RequestMapping(value="/CREM2016/payment", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public ListResponse getPayment(
			Integer deadId
			) throws Exception{
		return ListResponse.of(this.paymentService.getPaymentBD(deadId, Part.화장.code()));
	}

	@RequestMapping(value="/CREM2016/payment", method=RequestMethod.POST, produces=APPLICATION_JSON)
	public MapResponse savePayment(
			@DateTimeFormat(pattern="yyyy-MM-dd") Date cremDate
			, Integer cremSeq
			, @RequestBody Payment payment
			) throws Exception{

		HwaCremation hwaCremation = this.hwaCremationService.findOne(HwaCremationId.of(cremDate, cremSeq));

		Map<String, Object> res = MapUtils.getMap("payment", this.paymentService.savePayment(hwaCremation.getDeadId(), payment));

		res.put("hwaCremation", hwaCremation);

		return MapResponse.of(res);
	}

	@RequestMapping(value="/CREM2016/payment/cancel", method=RequestMethod.POST, produces=APPLICATION_JSON)
	public MapResponse savePayment(
			@DateTimeFormat(pattern="yyyy-MM-dd") Date cremDate
			, Integer cremSeq
			, Integer deadId
			, String tid
			, Integer seq
			, @RequestBody Payment payment
			) throws Exception{

		HwaCremation hwaCremation = this.hwaCremationService.findOne(HwaCremationId.of(cremDate, cremSeq));

		Map<String, Object> res = MapUtils.getMap("payment", this.paymentService.saveCancelPayment(hwaCremation.getDeadId(), PaymentId.of(deadId, tid, seq), payment));

		res.put("hwaCremation", hwaCremation);

		return MapResponse.of(res);
	}

	@RequestMapping(value="/CREM2016/hwaCremation", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public MapResponse savePayment(
			@DateTimeFormat(pattern="yyyy-MM-dd") Date cremDate
			, Integer cremSeq
			) throws Exception{

		HwaCremation hwaCremation = this.hwaCremationService.findOne(HwaCremationId.of(cremDate, cremSeq));

		Map<String, Object> res = MapUtils.getMap("hwaCremation", hwaCremation);

		return MapResponse.of(res);
	}

}
