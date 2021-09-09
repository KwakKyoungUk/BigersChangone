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
import net.bigers.funeralsystem.fune0000.domain.user_mng_part.UserMngPartService;

@Controller
public class FUNE5110Controller extends BaseController{

	private static final String BASIC_CD_MACHUL_TYPE = "112";
	private static final String BASIC_CD_JUNGSAN_TYPE = "312";

	@Inject
	private UserMngPartService userMngPartService;

	@Autowired
	private BasicCodeService basicCodeService;


	@RequestMapping(value="/FUNE5110/part", method={RequestMethod.POST}, produces=APPLICATION_JSON) // POST 방식을 사용하였는데, AXSearch 컴포넌트에서 AJAX 요청시 GET 방식으로 받아오지 않기에 POST방식으로 사용하였다.
	public CommonListResponseParams.ListResponse getPartList(){
		List<Part> list =  this.userMngPartService.getByCurrentUser();
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE5110/machul-type", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getMachulTypes(){
//		 전체선택 범위로 레포트를 검색시 빈 값으로 범위값을 전달하는 것이 아니라 5라는 값으로 전달하여 전체범위임을 알린다.
		List<BasicCode> list = basicCodeService.findByBasicCdAndPrependNameAndValue(BASIC_CD_MACHUL_TYPE, "전체선택", "");
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE5110/jungsan-type", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getJungsanTypes(){
		List<BasicCode> list = basicCodeService.findByBasicCdAndPrependNameAndValue(BASIC_CD_JUNGSAN_TYPE, "전체선택", "");
		return CommonListResponseParams.ListResponse.of(list);
	}

}
