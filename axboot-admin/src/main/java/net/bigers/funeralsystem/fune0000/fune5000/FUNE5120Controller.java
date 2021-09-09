package net.bigers.funeralsystem.fune0000.fune5000;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;

import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;

@Controller
public class FUNE5120Controller extends BaseController{
	
	private static final String BASIC_CD_JUNGSAN_TYPE = "312";
	private static final String BASIC_CD_JUNGSAN_DATE = "314";
	
	@Autowired
	private BasicCodeService basicCodeService;
	
	@RequestMapping(value="/FUNE5120/jungsandate", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getJungsanDate(){
		List<BasicCode> list = basicCodeService.findByBasicCd(BASIC_CD_JUNGSAN_DATE);
		return CommonListResponseParams.ListResponse.of(list);
	}
	
	@RequestMapping(value="/FUNE5120/jungsan", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getJungsanTypes(){
		List<BasicCode> list = basicCodeService.findByBasicCd(BASIC_CD_JUNGSAN_TYPE);
		return CommonListResponseParams.ListResponse.of(list);
	}


}
