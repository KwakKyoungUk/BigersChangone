package net.bigers.funeralsystem.fune0000.fune3000;

import java.util.List;

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
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroup;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroupService;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.fune0000.domain.user_mng_part.UserMngPartService;
import net.bigers.funeralsystem.fune0000.vto.CustomerVTO;

@Controller
public class FUNE3100Controller extends BaseController{

	@Inject
	private UserMngPartService userMngPartService;
	
	@RequestMapping(value="/FUNE3100/part", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getPart(){
		List<Part> list = this.userMngPartService.getByCurrentUser();
		return CommonListResponseParams.ListResponse.of(list);
	}
	
	@Inject
	private CustomerService CustomerService;
	
	@RequestMapping(value="/FUNE3100/customer", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getCustomer(
			@RequestParam(value="partCode", defaultValue="") String partCode){
		List<Customer> list = CustomerService.findByPartCode(partCode);
		return CommonListResponseParams.ListResponse.of(list);
	}
	
	@Inject
	private ItemGroupService ItemGroupService;
	
	@RequestMapping(value="/FUNE3100/itemgroup", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getItemGroup(
			@RequestParam(value="partCode", defaultValue="") String partCode){
		List<ItemGroup> list = ItemGroupService.findByPartCode(partCode);
		return CommonListResponseParams.ListResponse.of(list);
	}
	
	@Inject
	private BasicCodeService BasicCodeService;
	
	@RequestMapping(value="/FUNE3100/basiccode", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getBasicCode(){
		List<BasicCode> list = BasicCodeService.findByBasicCd("051");
		return CommonListResponseParams.ListResponse.of(list);
	}
	
	
}
