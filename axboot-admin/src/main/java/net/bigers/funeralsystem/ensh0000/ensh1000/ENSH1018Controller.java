package net.bigers.funeralsystem.ensh0000.ensh1000;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;

import net.bigers.funeralsystem.ensh0000.domain.ensret.Ensret;
import net.bigers.funeralsystem.ensh0000.domain.ensret.EnsretId;
import net.bigers.funeralsystem.ensh0000.domain.ensret.EnsretService;
import net.bigers.funeralsystem.fune0000.domain.dc_rate.DcRateService;
import net.bigers.funeralsystem.stan0000.domain.pricelist.PricelistService;
import net.bigers.funeralsystem.stan0000.domain.retlist.Retlist;
import net.bigers.funeralsystem.stan0000.domain.retlist.RetlistService;
import net.bigers.funeralsystem.stan0000.vto.RetlistVTO;

@Controller
public class ENSH1018Controller extends BaseController  {

	@Autowired
	private EnsretService ensretService;

	@Autowired
	private PricelistService pricelistService;

	@Autowired
	private RetlistService retlistService;

	@Autowired
	private DcRateService dcRateService;

	@RequestMapping(value="/ENSH1018/ensret", method=RequestMethod.PUT, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse putEnsret(
				@RequestBody Ensret ensret
			) throws Exception{

		Map<String, Object> res = new HashMap<>();

		res.put("ensret", ensretService.saveEnsret(ensret));

		return CommonListResponseParams.MapResponse.of(res);
	}

	@RequestMapping(value="/ENSH1018/ensret/{retDate}/{retSeq}", method=RequestMethod.DELETE, produces=APPLICATION_JSON)
	public ApiResponse deleteEnsret(
			@PathVariable("retDate") @DateTimeFormat(pattern="yyyyMMdd") Date retDate
			, @PathVariable("retSeq") Integer retSeq
			) throws Exception{

		ensretService.deleteEnsret(ensretService.findOne(EnsretId.of(retDate, retSeq)));
		return ok();
	}

	@RequestMapping(value="/ENSH1018/retlist/{strDate}/{retnDate}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse getRetlist(
			@PathVariable("strDate") @DateTimeFormat(pattern="yyyyMMdd") Date strDate,
			@PathVariable("retnDate") @DateTimeFormat(pattern="yyyyMMdd") Date retnDate
			){
		/**
		 * "2" : 봉안
		 * "1" : 사용료
		 */
		Retlist retlist = retlistService.findRet("E", "U", strDate,retnDate);

		Map<String, Object> res = new HashMap<>();

		res.put("retlistVTO", RetlistVTO.of(retlist));

		return CommonListResponseParams.MapResponse.of(res);
	}
}
