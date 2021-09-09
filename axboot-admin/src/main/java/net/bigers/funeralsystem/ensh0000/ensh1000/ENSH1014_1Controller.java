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

import net.bigers.funeralsystem.ensh0000.domain.ensext.Ensext;
import net.bigers.funeralsystem.ensh0000.domain.ensext.EnsextId;
import net.bigers.funeralsystem.ensh0000.domain.ensext.EnsextService;
import net.bigers.funeralsystem.ensh0000.domain.enshrine.Enshrine;
import net.bigers.funeralsystem.ensh0000.domain.enshrine.EnshrineId;
import net.bigers.funeralsystem.ensh0000.domain.enshrine.EnshrineService;
import net.bigers.funeralsystem.fune0000.domain.payment.Payment;
import net.bigers.funeralsystem.fune0000.domain.payment.PaymentId;
import net.bigers.funeralsystem.fune0000.domain.payment.PaymentService;
import net.bigers.funeralsystem.lib.util.MapUtils;

@Controller
public class ENSH1014_1Controller extends BaseController  {

	@Autowired
	private PaymentService paymentService;

	@Autowired
	private EnsextService ensextService;

	@RequestMapping(value="/ENSH1014_1/saleStmt", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public ListResponse getSaleStmt(
			@DateTimeFormat(pattern="yyyy-MM-dd") Date extDate
			, Integer extSeq
			) throws Exception{
		return ListResponse.of(this.ensextService.getSaleStmt(EnsextId.of(extDate, extSeq)));
	}

	@RequestMapping(value="/ENSH1014_1/payment", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public ListResponse getPayment(
			Integer deadId
			, String partCode
			) throws Exception{
		return ListResponse.of(this.paymentService.getPaymentBD(deadId, partCode));
	}

	@RequestMapping(value="/ENSH1014_1/payment", method=RequestMethod.POST, produces=APPLICATION_JSON)
	public MapResponse savePayment(
			Integer deadId
			, @DateTimeFormat(pattern="yyyy-MM-dd") Date extDate
			, Integer extSeq
			, @RequestBody Payment payment
			) throws Exception{

		Map<String, Object> res = MapUtils.getMap("payment", this.paymentService.savePayment(deadId, payment, EnsextId.of(extDate, extSeq)));

		res.put("ensext", this.ensextService.findOne(EnsextId.of(extDate, extSeq)));

		return MapResponse.of(res);

	}


	@RequestMapping(value="/ENSH1014_1/payment/cancel", method=RequestMethod.POST, produces=APPLICATION_JSON)
	public MapResponse savePayment(
			@DateTimeFormat(pattern="yyyy-MM-dd") Date extDate
			, Integer extSeq
			, Integer deadId
			, String tid
			, Integer seq
			, @RequestBody Payment payment
			) throws Exception{

		Ensext ensext = this.ensextService.findOne(EnsextId.of(extDate, extSeq));

		Map<String, Object> res = MapUtils.getMap("payment", this.paymentService.saveCancelPayment(deadId, PaymentId.of(deadId, tid, seq), payment));

		res.put("ensext", ensext);

		return MapResponse.of(res);
	}



	@RequestMapping(value="/ENSH1014_1/ensext", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public MapResponse getEnsext(
			@DateTimeFormat(pattern="yyyy-MM-dd") Date extDate
			, Integer extSeq
			) throws Exception{
		return MapResponse.of(MapUtils.getMap("ensext", this.ensextService.findOne(EnsextId.of(extDate, extSeq))));
	}
}
