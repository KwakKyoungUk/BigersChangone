package net.bigers.funeralsystem.suip0000.suip1000;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;

import net.bigers.funeralsystem.ensh0000.domain.enshrine.Enshrine;
import net.bigers.funeralsystem.fune0000.domain.payment.PaymentService;
import net.bigers.funeralsystem.fune0000.domain.payment_calc.PaymentCalcService;
import net.bigers.funeralsystem.suip0000.domain.suetc.Suetc;
import net.bigers.funeralsystem.suip0000.domain.suetc.SuetcService;

@Controller
public class SUIP1100Controller extends BaseController{

	@Autowired
	private PaymentCalcService paymentCalcService;

	@Autowired
	private SuetcService suetcService;

	@RequestMapping(value="/SUIP1100/paymentCalc/cen", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public List<Object> getPaymentCalcCen(
			@DateTimeFormat(pattern="yyyy-MM-dd") Date from
			, @DateTimeFormat(pattern="yyyy-MM-dd") Date to
			) throws Exception{
		return this.paymentCalcService.getCEN(from, to);
	}

	@RequestMapping(value="/SUIP1100/paymentCalc/funeral", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public List<Object> getPaymentCalcFuneral(
			@DateTimeFormat(pattern="yyyy-MM-dd") Date from
			, @DateTimeFormat(pattern="yyyy-MM-dd") Date to
			) throws Exception{
		return this.paymentCalcService.getFuneral(from, to);
	}

	@RequestMapping(value="/SUIP1100/suetc/{ocrPart}", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public List<Suetc> getSuetc(
			@DateTimeFormat(pattern="yyyy-MM-dd") Date from
			, @DateTimeFormat(pattern="yyyy-MM-dd") Date to
			, @PathVariable("ocrPart") String ocrPart
			) throws Exception{
		return this.suetcService.getSuetcSuip(ocrPart, from, to);
	}

	@RequestMapping(value="/SUIP1100/ensext", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public List<Object> getEnshrine(
			@DateTimeFormat(pattern="yyyy-MM-dd") Date from
			, @DateTimeFormat(pattern="yyyy-MM-dd") Date to
			) throws Exception{
		return this.paymentCalcService.getEnsext(from, to);
	}
}