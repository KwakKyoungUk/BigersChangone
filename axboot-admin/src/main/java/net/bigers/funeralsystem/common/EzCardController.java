package net.bigers.funeralsystem.common;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.core.api.response.ApiResponse;

import net.bigers.funeralsystem.common.domain.ez_card.EzCard;
import net.bigers.funeralsystem.common.domain.ez_card.EzCardService;

@Controller
public class EzCardController  extends BaseController {

	@Autowired
	private EzCardService ezCardService;

	@Autowired
	private KiccService kiccService;

	@RequestMapping(value="/ezCard", method=RequestMethod.POST, produces=APPLICATION_JSON)
	public ApiResponse getUrl(@RequestBody EzCard ezCard){
		this.ezCardService.save(ezCard);
		return ok();
	}

	@RequestMapping(value="/kicc/sign/img", method=RequestMethod.POST)
	public ApiResponse getSignImg(
			HttpServletRequest request
			, HttpServletResponse response
			, String signdata) throws IOException{

		byte[] img = kiccService.getSignImg(request.getRealPath("/"), signdata);


		return ok();
	}


}
