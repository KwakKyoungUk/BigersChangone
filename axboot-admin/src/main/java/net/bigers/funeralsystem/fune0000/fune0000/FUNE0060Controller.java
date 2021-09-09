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

import net.bigers.funeralsystem.fune0000.domain.item.ItemService;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroup;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroupService;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.fune0000.domain.set_group.SetGroup;
import net.bigers.funeralsystem.fune0000.domain.set_group.SetGroupService;
import net.bigers.funeralsystem.fune0000.domain.set_item.SetItem;
import net.bigers.funeralsystem.fune0000.domain.set_item.SetItemService;
import net.bigers.funeralsystem.fune0000.vto.ItemVTO;

@Controller
public class FUNE0060Controller extends BaseController{


	@Inject
	private PartService partService;

	@Inject
	private ItemGroupService itemGroupService;

	@Inject
	private SetGroupService setGroupService;

	@Inject
	private SetItemService setItemService;

	@Inject
	private ItemService itemService;

	@RequestMapping(value="/FUNE0060/part", method={RequestMethod.POST}, produces=APPLICATION_JSON) // POST 방식을 사용하였는데, AXSearch 컴포넌트에서 AJAX 요청시 GET 방식으로 받아오지 않기에 POST방식으로 사용하였다.
	public CommonListResponseParams.ListResponse getPartList(){
		List<Part> list =  partService.findByOrderByPartCodeAsc();
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE0060/itemGroup", method={RequestMethod.GET}, produces=APPLICATION_JSON) // POST 방식을 사용하였는데, AXSearch 컴포넌트에서 AJAX 요청시 GET 방식으로 받아오지 않기에 POST방식으로 사용하였다.
	public CommonListResponseParams.ListResponse getItemGroupList(@RequestParam(value="partCode", required=false, defaultValue="") String partCode){
		//List<ItemGroup> list =  itemGroupService.getItemGroupList(partCode);
		List<ItemGroup> list = itemGroupService.findByPartCodeStartingWithOrderBySortNoAsc(partCode);

		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE0060/item", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getItemList(
			@RequestParam(value="partCode") String partCode,
			@RequestParam(value="groupCode") String groupCode){
		List<ItemVTO> list = itemService.findByPartCodeAndGroupCode(partCode, groupCode);
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE0060/setGroup", method={RequestMethod.GET}, produces=APPLICATION_JSON) // POST 방식을 사용하였는데, AXSearch 컴포넌트에서 AJAX 요청시 GET 방식으로 받아오지 않기에 POST방식으로 사용하였다.
	public CommonListResponseParams.ListResponse getSetGroupList(@RequestParam(value="partCode", required=false, defaultValue="") String partCode){
		List<SetGroup> list = setGroupService.findByPartCodeStartingWithOrderBySortNoAsc(partCode);
		return CommonListResponseParams.ListResponse.of(list);
	}


	@RequestMapping(value="/FUNE0060/item-by-set-code", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getItemBySetCode(
			@RequestParam(value="partCode") String partCode,
			@RequestParam(value="setCode") String setCode){
		List<ItemVTO> list = setItemService.findByPartCodeAndSetCode(partCode, setCode);
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE0060/setItem", method={RequestMethod.PUT}, produces=APPLICATION_JSON)
	public ApiResponse saveSetItem(
			@RequestParam(value="partCode") String partCode,
			@RequestParam(value="setCode") String setCode,
			@RequestBody List<SetItem> list
			){
		setItemService.addItemToSetItem(partCode, setCode, list);
		return ok();
	}

	@RequestMapping(value="/FUNE0060/first-part", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public Part getFirstPart(){
		return partService.findFirstByOrderByPartCodeAsc();
	}

	@RequestMapping(value="/FUNE0060/itemGroup-code", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getItemGroupCodeList(){
		// 그룹코드와 그룹명만 렌더링하고 싶으므로 VTO 사용.
		List<ItemVTO> list = itemGroupService.findGroupCodeAndGroupName();
		return CommonListResponseParams.ListResponse.of(list);
	}

}
