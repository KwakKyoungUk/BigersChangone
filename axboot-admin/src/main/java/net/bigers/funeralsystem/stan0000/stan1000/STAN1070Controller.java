package net.bigers.funeralsystem.stan0000.stan1000;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;

import net.bigers.funeralsystem.suip0000.domain.susemok_cd.SusemokCd;
import net.bigers.funeralsystem.suip0000.domain.susemok_cd.SusemokCdService;

@Controller
@Transactional
public class STAN1070Controller extends BaseController {

	@Autowired
	private SusemokCdService susemokCdService;

	@RequestMapping(value="/STAN1070/susemok-cd", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getSusemokCd() throws Exception{

		return CommonListResponseParams.ListResponse.of(this.susemokCdService.findAll());
	}

	@RequestMapping(value="/STAN1070/susemok-cd", method= {RequestMethod.PUT, RequestMethod.POST}, produces=APPLICATION_JSON)
	public ApiResponse putSusemokCd(@RequestBody List<SusemokCd> susemokCd) throws Exception{
		this.susemokCdService.save(susemokCd);
		return ok();
	}

	@RequestMapping(value="/STAN1070/susemok-cd", method= {RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deleteSusemokCd(@RequestBody List<SusemokCd> susemokCd) throws Exception{
		this.susemokCdService.delete(susemokCd);
		return ok();
	}

}
