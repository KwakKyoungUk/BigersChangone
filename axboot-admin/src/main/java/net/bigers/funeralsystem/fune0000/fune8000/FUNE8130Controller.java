package net.bigers.funeralsystem.fune0000.fune8000;

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
public class FUNE8130Controller extends BaseController{

	@Inject
	private BasicCodeService basicCodeService;
	
	@RequestMapping(value="/FUNE8130/part", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getPartCode(){
		List<BasicCode> list = basicCodeService.findByBasicCd("506");
		return CommonListResponseParams.ListResponse.of(list);
	}
}
