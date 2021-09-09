package net.bigers.funeralsystem.fune0000.fune2000;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;

import net.bigers.funeralsystem.fune0000.domain.customer.Customer;
import net.bigers.funeralsystem.fune0000.domain.customer.CustomerService;
import net.bigers.funeralsystem.fune0000.domain.item.ItemService;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroup;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroupService;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.fune0000.domain.user_mng_part.UserMngPartService;
import net.bigers.funeralsystem.fune0000.vto.CustomerVTO;

@Controller
public class FUNE2101Controller extends BaseController{

	@Inject
	private ItemGroupService itemGroupService;

	@Inject
	private BasicCodeService basicCodeService;

	@Inject
	private UserMngPartService userMngPartService;

	@RequestMapping(value="/FUNE2101/part", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getPart(){
		List<Part> list = this.userMngPartService.getByCurrentUser();
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE2101/itemgroup", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getCust(
			@RequestParam(value="partCode", defaultValue="") String partCode){
		List<ItemGroup> list = itemGroupService.findByPartCode(partCode);
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE2101/item" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public List<Object[]> findItem(@RequestParam Map<String, String> requestBody) throws Exception{
		return this.itemGroupService.findItemHistorySale(requestBody);
	}

//	@RequestMapping(value="/FUNE2101/code" , method= RequestMethod.POST, produces=APPLICATION_JSON )
//	public CommonListResponseParams.ListResponse getCode() throws Exception{
//		List<BasicCode> list = basicCodeService.findByBasicCd("051");
//		return CommonListResponseParams.ListResponse.of(list);
//	}
}
