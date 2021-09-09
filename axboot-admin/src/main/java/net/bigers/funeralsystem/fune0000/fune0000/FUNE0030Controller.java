package net.bigers.funeralsystem.fune0000.fune0000;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;

import net.bigers.funeralsystem.fune0000.domain.customer.Customer;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroup;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroupService;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;

@Controller
public class FUNE0030Controller extends BaseController{
	
	@Inject
	private ItemGroupService itemGroupService;
	
	@Inject
	private PartService partService;
	
	
	@RequestMapping(value="/FUNE0030/part", method={RequestMethod.POST}, produces=APPLICATION_JSON) // POST 방식을 사용하였는데, AXSearch 컴포넌트에서 AJAX 요청시 GET 방식으로 받아오지 않기에 POST방식으로 사용하였다.
	public CommonListResponseParams.ListResponse getPartList(){
		List<Part> list =  partService.findByOrderByPartCodeAsc();
		return CommonListResponseParams.ListResponse.of(list);
	}
	
	@RequestMapping(value="/FUNE0030/itemGroup", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getList(
			@RequestParam(value="partCode", required=false, defaultValue="") String partCode, 
			@RequestParam(value="groupCode", required=false, defaultValue="") String groupCode, 
			@RequestParam(value="groupName", required=false, defaultValue="") String groupName){
		
		List<ItemGroup> list = itemGroupService.findByPartCodeStartingWithAndGroupCodeStartingWithAndGroupNameContainingOrderBySortNoAsc(
					partCode, groupCode, groupName
				);
		
		return CommonListResponseParams.ListResponse.of(list); 
	}
	
	@RequestMapping(value="/FUNE0030/itemGroup", method={RequestMethod.PUT}, produces=APPLICATION_JSON)
	public ApiResponse saveItemGroup(@RequestBody List<ItemGroup> list){
		itemGroupService.save(list);
		return ok();
	}
	
	@RequestMapping(value="/FUNE0030/itemGroup", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse delItemGroup(@RequestBody List<ItemGroup> list) throws Exception{
		itemGroupService.delete(list);
		return ok();
	}

}
