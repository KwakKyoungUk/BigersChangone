package net.bigers.funeralsystem.fune0000.fune2000;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;

import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroup;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroupService;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.user_mng_part.UserMngPartService;

@Controller
public class FUNE2090Controller extends BaseController{

	@Inject
	private UserMngPartService userMngPartService;

	@Inject
	private BasicCodeService basicCodeService;
	
	@Inject
	private ItemGroupService ItemGroupService;
	
	@RequestMapping(value="/FUNE2090/part", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getPart(){
		List<Part> list = userMngPartService.getByCurrentUser();
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE2090/basiccode", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getBasicCode(){
		List<BasicCode> list = basicCodeService.findByBasicCd("111");
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE2090/basiccode2", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getBasicCode2(){
		List<BasicCode> list = basicCodeService.findByBasicCd("112");
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE2090/itemgroup", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getitemgroup(String partCode){
		List<ItemGroup> list = ItemGroupService.findByPartCode(partCode);
		return CommonListResponseParams.ListResponse.of(list);
	}
}
