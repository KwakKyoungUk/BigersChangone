package net.bigers.funeralsystem.fune0000.fune5000;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.common.vto.OptionVTO;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.fune0000.domain.payment.PaymentService;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt.SaleStmtService;
import net.bigers.funeralsystem.fune0000.domain.total_part.TotalPartService;
import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.lib.util.MapUtils.MapItem;

@Controller
public class FUNE5013Controller extends BaseController {

	@Autowired
	private PaymentService paymentService;

	@ApiOperation(value = "결제금액", notes = "결제금액")
	@RequestMapping(value="/FUNE5013/pay" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public MapResponse getPay(String customerNo, Double receiptAmt) throws Exception{

		return MapResponse.of(MapUtils.getMap(MapItem.of("pay", this.paymentService.getPay(customerNo, receiptAmt))));
	}

}
