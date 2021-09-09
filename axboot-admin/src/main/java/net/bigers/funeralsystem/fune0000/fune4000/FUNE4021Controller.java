/*****************************************************************************
 * 프로그램명  : FUNE4021Controller.java
 * 설     명  : 생산 관리 > 식단관리 > 등록 , 수정 팝업 처리 컨트롤러
 * 참고  사항  : 없음
 *****************************************************************************
 * Date       Author  Version Description
 * ---------- ------- ------- -----------------------------------------------
 * 2017.11.09  KYM    1.0     초기작성
 *****************************************************************************/
package net.bigers.funeralsystem.fune0000.fune4000;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.fune0000.domain.item.Item;
import net.bigers.funeralsystem.fune0000.domain.item.ItemService;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroup;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroupService;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.lib.util.MapUtils.MapItem;
import com.axisj.axboot.core.api.response.ApiResponse;

import net.bigers.funeralsystem.fune0000.domain.recipe.Recipe;
import net.bigers.funeralsystem.fune0000.domain.recipe.RecipeService;
import net.bigers.funeralsystem.fune0000.domain.recipe_item.RecipeItemService;
import net.bigers.funeralsystem.fune0000.domain.recipe_item.RecipeItem;
import net.bigers.funeralsystem.fune0000.vto.ItemVTO;
import net.bigers.funeralsystem.fune0000.vto.RecipeVTO;

@Controller
public class FUNE4021Controller extends BaseController{
	
	@Autowired
	private PartService partService;
		
	@Autowired
	private ItemService itemService;
	@Autowired
	private ItemGroupService itemGroupService;
	@Autowired
	RecipeService recipeService;
	@Autowired
	RecipeItemService recipeItemService;
	

	
	/**
	 * 검색 콤보 파트 목록 취득
	 */
	@ApiOperation(value = "검색파트", notes = "검색파트")
	@RequestMapping(value="/FUNE4021/part", method={RequestMethod.POST}, produces=APPLICATION_JSON) // POST 방식을 사용하였는데, AXSearch 컴포넌트에서 AJAX 요청시 GET 방식으로 받아오지 않기에 POST방식으로 사용하였다.
	public CommonListResponseParams.ListResponse getPartList(String partGroupCode){
		List<Part> list =  partService.findByPartGroupCodeOrderByPartCodeAsc(partGroupCode);
		return CommonListResponseParams.ListResponse.of(list);
	}
	/**
	 *  검색 식품분류 콤보 정보 취득
	 * @param String partCode
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "식품분류", notes = "식품분류")
	@RequestMapping(value="/FUNE4021/recipe/itemGroup" , method= RequestMethod.POST, produces=APPLICATION_JSON )
	public ListResponse getItemGroup(String partCode) throws Exception{
		List<ItemGroup> resList = this.itemGroupService.findByPartCodeOrderByGroupCode(partCode);
		return ListResponse.of(resList);
	}

	/**
	 * 우측 레시피 아이템 정보 취득
	 * @param String partCode
	 * @param String itemCode
	 * @param String recipeCode
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "식단 등록 우측 레시피 아이템 정보", notes = "식단 등록 우측 레시피 아이템 정보")
	@RequestMapping(value="/FUNE4021/recipe" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public MapResponse getBuyStmtBdDef(String partCode, String itemCode, String recipeCode) throws Exception{		
		return MapResponse.of(MapUtils.getMap(MapItem.of("recipe", this.recipeService.getRecipe(partCode, itemCode, recipeCode))));
	}
	
	/**
	 * 좌측 검색 그리드 1 아이템 목록 취득
	 * @param requestBody
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "아이템 목록", notes = "아이템 목록")
	@RequestMapping(value="/FUNE4021/recipe/item" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public CommonListResponseParams.ListResponse findItem(@RequestParam Map<String, String> requestBody) throws Exception{
		String partCode 	= requestBody.get("partCode");
		String groupCode 	= requestBody.get("groupCode");
		String itemCode 	= requestBody.get("itemCode");
		String itemName 	= requestBody.get("itemName");
		List<Item> list = itemService.findByItemItemCodeStartingWithAndItemName(
				partCode, groupCode, itemCode, itemName
		);		
		return CommonListResponseParams.ListResponse.of(list);
	}

	/**
	 * 좌측 검색 그리드 2 레시피 아이템 목록 취득
	 * @param requestBody
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "레시피 아이템 목록", notes = "레시피 아이템 목록")
	@RequestMapping(value="/FUNE4021/recipe/recipeItem" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public CommonListResponseParams.ListResponse findRecipeItem(@RequestParam Map<String, String> requestBody) throws Exception{
		String partCode 		= requestBody.get("partCode");
		String groupCode 		= requestBody.get("groupCode");
		String itemCode 		= requestBody.get("itemCode");		
		String recipeCode		= requestBody.get("recipeCode");
		String itemName 		= requestBody.get("itemName");
		
		List<RecipeItem> list = recipeItemService.findByMenuRecipeItem(partCode, groupCode, itemCode, recipeCode, itemName);
		return CommonListResponseParams.ListResponse.of(list);
	}
	
	/**
	 * 식단 저장
	 * @param ProductionStmtVTO
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "식단 저장", notes = "식단 저장")
	@RequestMapping(value="/FUNE4021/recipe" , method= RequestMethod.POST, produces=APPLICATION_JSON )
	public MapResponse saveBuyStmt(@RequestBody RecipeVTO recipeVTO) throws Exception{
		System.out.println("CONTROLLER=" + recipeVTO.getRecipeCode() + " ^^^^^^ "+ recipeVTO.toString());
		
		return MapResponse.of(MapUtils.getMap(MapItem.of("recipe", this.recipeService.saveRecipe(recipeVTO))));
	}
	
	/**
	 * 식단  삭제
	 * @param ProductionStmt
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = " 식단 삭제", notes = "식단 삭제")
	@RequestMapping(value="/FUNE4021/recipe" , method= RequestMethod.DELETE, produces=APPLICATION_JSON )
	public ApiResponse deleteProductionStmt(@RequestBody Recipe recipe) throws Exception{

		this.recipeService.deleteRecipe(recipe);

		return ok();
	}
}
