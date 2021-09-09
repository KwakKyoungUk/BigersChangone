package net.bigers.funeralsystem.ensh0000.ensh1000;

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
import com.axisj.axboot.core.api.response.ApiResponse;

import net.bigers.funeralsystem.crem0000.domain.hwacremation.HwaCremation;
import net.bigers.funeralsystem.crem0000.domain.hwacremation.HwaCremationId;
import net.bigers.funeralsystem.ensh0000.domain.ensdead.EnsdeadId;
import net.bigers.funeralsystem.ensh0000.domain.enshrine.Enshrine;
import net.bigers.funeralsystem.ensh0000.domain.enshrine.EnshrineId;
import net.bigers.funeralsystem.ensh0000.domain.enshrine.EnshrineService;
import net.bigers.funeralsystem.fune0000.domain.payment.Payment;
import net.bigers.funeralsystem.fune0000.domain.payment.PaymentId;
import net.bigers.funeralsystem.fune0000.domain.payment.PaymentService;
import net.bigers.funeralsystem.lib.util.MapUtils;

@Controller
public class ENSH1010_4Controller extends BaseController  {

	@Autowired
	private PaymentService paymentService;

	@Autowired
	private EnshrineService enshrineService;

	@RequestMapping(value="/ENSH1010_4/saleStmt", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public ListResponse getSaleStmt(
			@DateTimeFormat(pattern="yyyy-MM-dd") Date ensDate
			, Integer ensSeq
			, Integer deadSeq
			) throws Exception{
		return ListResponse.of(this.enshrineService.getSaleStmt(EnsdeadId.of(ensDate, ensSeq, deadSeq)));
	}

	@RequestMapping(value="/ENSH1010_4/payment", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public ListResponse getPayment(
			Integer deadId
			, String partCode
			) throws Exception{
		return ListResponse.of(this.paymentService.getPaymentBD(deadId, partCode));
	}

	@RequestMapping(value="/ENSH1010_4/payment", method=RequestMethod.POST, produces=APPLICATION_JSON)
	public MapResponse savePayment(
			@DateTimeFormat(pattern="yyyy-MM-dd") Date ensDate
			, Integer ensSeq
			, Integer deadId
			, @RequestBody Payment payment
			) throws Exception{

		Map<String, Object> res = MapUtils.getMap("payment", this.paymentService.savePayment(deadId, payment));

		res.put("enshrine", this.enshrineService.findOne(EnshrineId.of(ensDate, ensSeq)));

		return MapResponse.of(res);
	}

	@RequestMapping(value="/ENSH1010_4/payment/cancel", method=RequestMethod.POST, produces=APPLICATION_JSON)
	public MapResponse savePayment(
			@DateTimeFormat(pattern="yyyy-MM-dd") Date ensDate
			, Integer ensSeq
			, Integer deadId
			, String tid
			, Integer seq
			, @RequestBody Payment payment
			) throws Exception{


		Map<String, Object> res = MapUtils.getMap("payment", this.paymentService.saveCancelPayment(deadId, PaymentId.of(deadId, tid, seq), payment));

		Enshrine enshrine = this.enshrineService.findOne(EnshrineId.of(ensDate, ensSeq));
		res.put("enshrine", enshrine);

		return MapResponse.of(res);
	}

	@RequestMapping(value="/ENSH1010_4/enshrine", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public MapResponse savePayment(
			@DateTimeFormat(pattern="yyyy-MM-dd") Date ensDate
			, Integer ensSeq
			) throws Exception{

		Enshrine enshrine = this.enshrineService.findOne(EnshrineId.of(ensDate, ensSeq));

		Map<String, Object> res = MapUtils.getMap("enshrine", enshrine);

		return MapResponse.of(res);
	}
}
