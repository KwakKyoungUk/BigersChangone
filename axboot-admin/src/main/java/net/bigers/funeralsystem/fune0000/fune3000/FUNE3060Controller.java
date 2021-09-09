package net.bigers.funeralsystem.fune0000.fune3000;

import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;

import net.bigers.funeralsystem.fune0000.domain.customer.Customer;
import net.bigers.funeralsystem.fune0000.domain.customer.CustomerService;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.fune0000.domain.user_mng_part.UserMngPartService;
import net.bigers.funeralsystem.fune0000.vto.CustomerVTO;

@Controller
public class FUNE3060Controller extends BaseController{

	@Inject
	private UserMngPartService userMngPartService;

	@Inject
	private PartService partService;

	@RequestMapping(value="/FUNE3060/part", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getPart(){
		List<Part> list = this.userMngPartService.getByCurrentUser();
		if(list.stream().anyMatch(p->p.getPartCode().equals(net.bigers.funeralsystem.fune0000.domain.funeral.Part.화원.code()))){
			if(!list.stream().anyMatch(p->p.getPartCode().equals(net.bigers.funeralsystem.fune0000.domain.funeral.Part.매점.code()))){
				Part store = this.partService.findOne(net.bigers.funeralsystem.fune0000.domain.funeral.Part.매점.code());
				list.add(store);
				list.sort(Comparator.comparing(Part::getSortNo));
			}
		}
		return CommonListResponseParams.ListResponse.of(list);
	}

	@Inject
	private CustomerService CustomerService;

	@RequestMapping(value="/FUNE3060/customer", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getCustomer(
			@RequestParam(value="partCode", defaultValue="") String partCode){
		List<Customer> list = CustomerService.findByPartCode(partCode);
		return CommonListResponseParams.ListResponse.of(list);
	}

}
