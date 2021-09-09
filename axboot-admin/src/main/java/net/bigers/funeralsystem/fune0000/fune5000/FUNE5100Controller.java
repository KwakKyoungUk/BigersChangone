package net.bigers.funeralsystem.fune0000.fune5000;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;

@Controller
public class FUNE5100Controller extends BaseController{

	private static final String BASIC_CD_MACHUL_TYPE = "112";
	private static final String BASIC_CD_JUNGSAN_TYPE = "312";
	
	
	@Autowired
	private BasicCodeService basicCodeService;
	
	
	@RequestMapping(value="/FUNE5100/machul-type", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getMachulTypes(){
		// 전체선택 범위로 레포트를 검색시 빈 값으로 범위값을 전달하는 것이 아니라 5라는 값으로 전달하여 전체범위임을 알린다.
		List<BasicCode> list = basicCodeService.findByBasicCdAndPrependNameAndValue(BASIC_CD_MACHUL_TYPE, "전체선택", "5");
		return CommonListResponseParams.ListResponse.of(list);
	}
	
	@RequestMapping(value="/FUNE5100/jungsan-type", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getJungsanTypes(){
		List<BasicCode> list = basicCodeService.findByBasicCdAndPrependNameAndValue(BASIC_CD_JUNGSAN_TYPE, "전체선택", "5");
		return CommonListResponseParams.ListResponse.of(list);
	}

	

}
