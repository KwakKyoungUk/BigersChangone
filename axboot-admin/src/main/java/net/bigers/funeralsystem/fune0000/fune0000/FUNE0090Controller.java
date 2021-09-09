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

import net.bigers.funeralsystem.fune0000.domain.item.Item;
import net.bigers.funeralsystem.fune0000.domain.item.ItemService;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.fune0000.domain.recipe.Recipe;
import net.bigers.funeralsystem.fune0000.domain.recipe.RecipeService;
import net.bigers.funeralsystem.fune0000.vto.ItemVTO;

@Controller
public class FUNE0090Controller extends BaseController {
	
	private static final String ITEM_KIND_CODE = "40";
	
	
	@Inject
	private PartService partService;
	
	@Inject
	private ItemService itemService;
	
	@Inject
	private RecipeService recipeService;
	
	@Inject
	private BasicCodeService basicCodeService;
	
	@RequestMapping(value="/FUNE0090/part", method={RequestMethod.POST}, produces=APPLICATION_JSON) // POST 방식을 사용하였는데, AXSearch 컴포넌트에서 AJAX 요청시 GET 방식으로 받아오지 않기에 POST방식으로 사용하였다.
	public CommonListResponseParams.ListResponse getPartList(){
		List<Part> list =  partService.findByOrderByPartCodeAsc();
		return CommonListResponseParams.ListResponse.of(list);
	}
	
	@RequestMapping(value="/FUNE0090/item", method={RequestMethod.GET, RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getItems(@RequestParam(value="partCode") String partCode){
		List<Item> list = itemService.findByPartCodeAndItemKindCode(partCode, ITEM_KIND_CODE);
		return CommonListResponseParams.ListResponse.of(list);
	}
	
	@RequestMapping(value="/FUNE0090/recipe", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getRecipeList(
			@RequestParam(value="partCode") String partCode,
			@RequestParam(value="itemCode", required=false) String itemCode){
		// 생산제품명을 가져오기 위해 VTO 사용
		List<ItemVTO> list = recipeService.findByPartCodeAndItemCode(partCode, itemCode);
		return CommonListResponseParams.ListResponse.of(list);
	}

	// Method-POST : SELECT 바인드시 ajax요청은 post로 진행이 됨.
	@RequestMapping(value="/FUNE0090/auto-code-options", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getAutoCodeCodes(){
		List<BasicCode> list = basicCodeService.findByBasicCd(RecipeService.AUTO_CODE_BASIC_CD);
		return CommonListResponseParams.ListResponse.of(list);
	}
	
	@RequestMapping(value="/FUNE0090/recipe", method={RequestMethod.PUT}, produces=APPLICATION_JSON)
	public ApiResponse saveRecipe(@RequestBody List<Recipe> list){
		recipeService.save(list);
		return ok();
	}
	
	@RequestMapping(value="/FUNE0090/recipe", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse removeRecipe(@RequestBody Recipe recipe){
		recipeService.delete(recipe);
		return ok();
	}
	
}
