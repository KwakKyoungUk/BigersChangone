package net.bigers.funeralsystem.fune0000.fune8000;

import java.util.Date;

import javax.inject.Inject;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;

import net.bigers.funeralsystem.fune0000.domain.payment.PaymentService;

@Controller
public class FUNE8160Controller extends BaseController{

	@Inject
	private PaymentService paymentService;

	@RequestMapping(value="/FUNE8160/deposit", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getDiposit(
			@DateTimeFormat(pattern="yyyy-MM-dd") Date from
			, @DateTimeFormat(pattern="yyyy-MM-dd") Date to
			){

		return CommonListResponseParams.ListResponse.of(this.paymentService.getDeposit(from, to));
	}
}
