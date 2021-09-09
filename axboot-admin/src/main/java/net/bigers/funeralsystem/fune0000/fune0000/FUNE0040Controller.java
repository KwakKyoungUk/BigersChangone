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
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;

import net.bigers.funeralsystem.fune0000.domain.customer.Customer;
import net.bigers.funeralsystem.fune0000.domain.customer.CustomerService;
import net.bigers.funeralsystem.fune0000.domain.item.Item;
import net.bigers.funeralsystem.fune0000.domain.item.ItemService;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroup;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroupService;
import net.bigers.funeralsystem.fune0000.domain.item_price.ItemPrice;
import net.bigers.funeralsystem.fune0000.domain.item_price.ItemPriceService;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.fune0000.vto.ItemVTO;

@Controller
public class FUNE0040Controller extends BaseController{

	@Inject
	private PartService partService;

	@Inject
	private ItemGroupService itemGroupService;

	@Inject
	private ItemService itemService;

	@Inject
	private CustomerService customerService;

	@Inject
	private ItemPriceService itemPriceService;

	@Inject
	private BasicCodeService basicCodeService;


	@RequestMapping(value="/FUNE0040/part", method={RequestMethod.POST}, produces=APPLICATION_JSON) // POST 방식을 사용하였는데, AXSearch 컴포넌트에서 AJAX 요청시 GET 방식으로 받아오지 않기에 POST방식으로 사용하였다.
	public CommonListResponseParams.ListResponse getPartList(){
		List<Part> list =  partService.findByOrderByPartCodeAsc();
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE0040/itemGroup", method={RequestMethod.GET}, produces=APPLICATION_JSON) // POST 방식을 사용하였는데, AXSearch 컴포넌트에서 AJAX 요청시 GET 방식으로 받아오지 않기에 POST방식으로 사용하였다.
	public CommonListResponseParams.ListResponse getItemGroupList(@RequestParam(value="partCode", required=false, defaultValue="") String partCode){
		List<ItemGroup> list =  itemGroupService.findByPartCode(partCode);
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE0040/item", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getItemGroup(
			@RequestParam(value="partCode", required=false, defaultValue="") String partCode,
			@RequestParam(value="groupCode", required=false, defaultValue="") String groupCode,
			@RequestParam(value="itemCode", required=false, defaultValue="") String itemCode,
			@RequestParam(value="itemName", required=false, defaultValue="") String itemName){

		List<ItemVTO> list = itemService.getItem(
				partCode, groupCode, itemCode, itemName
		);

		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE0040/customer-select-options", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getCustomerSelectOptions(String partCode){
		List<Customer> list = customerService.findByPartCodeOrderBySortNoAsc(partCode);
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE0040/itemGroup-select-options", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getItemGroupSelectOptions(String partCode){
		List<ItemGroup> list = itemGroupService.findByPartCodeOrderBySortNoAsc(partCode);
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE0040/price-grid", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getSalePriceGridList(
			@RequestParam(value="partCode") String partCode,
			@RequestParam(value="itemCode") String itemCode,
			@RequestParam(value="kind") Integer kind
		){
		List<ItemPrice> list = itemPriceService.findByPartCodeAndItemCodeAndKindOrderByStDateAsc(partCode, itemCode, kind);
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE0040/basic-select-options", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getBasicSelectOptionList(){
		List<BasicCode> list = basicCodeService.findByBasicCd("038");
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE0040/item", method={RequestMethod.PUT}, produces=APPLICATION_JSON)
	public ApiResponse saveItem(@RequestBody List<Item> list){
		itemService.saveItems(list);
		return ok();
	}

	@RequestMapping(value="/FUNE0040/price", method={RequestMethod.PUT}, produces=APPLICATION_JSON)
	public ApiResponse saveSalePrice(@RequestBody ItemPrice itemPrice){
		//itemPriceService.saveWithTimeAdded(itemPrice);
		itemPriceService.save(itemPrice);
		return ok();
	}

	@RequestMapping(value="/FUNE0040/price-last", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse removeSalePriceLast(@RequestBody ItemPrice itemPrice){
		itemPriceService.delete(itemPrice);
		return ok();
	}

	@RequestMapping(value="/FUNE0040/item", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse removeItem(@RequestBody Item item){
		itemPriceService.removeByPartCodeAndItemCode(item.getPartCode(), item.getItemCode());
		itemService.delete(item);
		return ok();
	}
}
