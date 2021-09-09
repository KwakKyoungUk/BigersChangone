package net.bigers.funeralsystem.fune0000.fune6000;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;

@Controller
public class FUNE6020Controller extends BaseController{
	
	@Inject
	private BasicCodeService BasicCodeService;
	
	@RequestMapping(value="/FUNE6020/basiccode", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getBasicCode(){
		List<BasicCode> list = BasicCodeService.findByBasicCd("111");
		return CommonListResponseParams.ListResponse.of(list);
	}
	
	@RequestMapping(value="/FUNE6020/basiccode2", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getBasicCode2(){
		List<BasicCode> list = BasicCodeService.findByBasicCd("112");
		return CommonListResponseParams.ListResponse.of(list);
	}
}
