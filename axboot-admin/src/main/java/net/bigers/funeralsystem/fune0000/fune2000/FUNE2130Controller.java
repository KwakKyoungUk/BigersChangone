package net.bigers.funeralsystem.fune0000.fune2000;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

import javax.inject.Inject;

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
public class FUNE2130Controller extends BaseController{

	@Inject
	private UserMngPartService userMngPartService;

	@Inject
	private BasicCodeService BasicCodeService;

	@RequestMapping(value="/FUNE2130/part", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getPart(){
		List<Part> list = this.userMngPartService.getByCurrentUser();
		return CommonListResponseParams.ListResponse.of(list.stream().filter(Objects::nonNull).collect(Collectors.toList()));
	}

	@RequestMapping(value="/FUNE2130/basiccode", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getBasicCode(){
		List<BasicCode> list = BasicCodeService.findByBasicCd("314");
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE2130/basiccode2", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getBasicCode2(){
		List<BasicCode> list = BasicCodeService.findByBasicCd("112");
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE2130/basiccode3", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getBasicCode3(){
		List<BasicCode> list = BasicCodeService.findByBasicCd("312");
		return CommonListResponseParams.ListResponse.of(list);
	}


}
