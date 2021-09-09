package net.bigers.funeralsystem.fune0000.fune0000;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.core.api.response.ApiResponse;

import net.bigers.funeralsystem.common.vto.OptionVTO;
import net.bigers.funeralsystem.fune0000.domain.item.ItemService;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroup;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroupService;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.fune0000.domain.recipe_item.RecipeItem;
import net.bigers.funeralsystem.fune0000.domain.recipe_item.RecipeItemService;
import net.bigers.funeralsystem.fune0000.vto.ItemVTO;

@Controller
public class FUNE0091Controller extends BaseController {

	@Inject
	private ItemService itemService;

	@Inject
	private ItemGroupService itemGroupService;

	@Autowired
	private PartService partService;

	@Autowired
	private RecipeItemService recipeItemService;

	@RequestMapping(value="/FUNE0091/item", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getItems(
			String partCode
			, String groupCode
			, String itemCode
			, String itemName
			){
		List<ItemVTO> list = itemService.findByPartCodeAndGroupCodeAndItemCodeAndItemName(partCode, groupCode, itemCode, itemName);
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE0091/part", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public List<OptionVTO> getPart(String partCode){
		Part part = this.partService.findOne(partCode);
		return Arrays.asList(OptionVTO.of(part.getPartCode(), part.getPartName()));
	}

	@RequestMapping(value="/FUNE0091/groupCode", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public List<OptionVTO> getItemGroupCode(String partCode){
		List<ItemGroup> itemGroups = this.itemGroupService.findByPartCode(partCode);
		return itemGroups.stream().map(ig->OptionVTO.of(ig.getGroupCode(), ig.getGroupName())).collect(Collectors.toList());
	}

	@RequestMapping(value="/FUNE0091/recipe-item", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public ListResponse getRecipeItem(
				String partCode
				, String itemCode
				, String recipeCode
			){
		List<RecipeItem> recipeItems = this.recipeItemService.getRecipeItems(partCode, itemCode, recipeCode);
		return ListResponse.of(recipeItems);
	}

	@RequestMapping(value="/FUNE0091/recipe-item/{partCode}/{itemCode}/{recipeCode}", method={RequestMethod.PUT}, produces=APPLICATION_JSON)
	public ApiResponse putRecipeItem(
			@PathVariable("partCode") String partCode
			, @PathVariable("itemCode") String itemCode
			, @PathVariable("recipeCode") String recipeCode
			, @RequestBody List<RecipeItem> recipeItems
			){
		this.recipeItemService.deleteAndSave(partCode, itemCode, recipeCode, recipeItems);
		return ok();
	}


}
