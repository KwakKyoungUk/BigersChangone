/*****************************************************************************
 * 프로그램명  : FUNE4070Controller.java
 * 설     명  : 자재소모내역 처리 컨트롤러
 * 참고  사항  : 없음
 *****************************************************************************
 * Date       Author  Version Description
 * ---------- ------- ------- -----------------------------------------------
 * 2017.11.28  KYM    1.0     초기작성
 *****************************************************************************/
package net.bigers.funeralsystem.fune0000.fune4000;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.admin.parameter.PageableResponseParams;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.core.dto.PageableTO;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.common.vto.OptionVTO;
import net.bigers.funeralsystem.fune0000.domain.item.Item;
import net.bigers.funeralsystem.fune0000.domain.item.ItemService;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroup;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroupService;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.fune0000.domain.production_stmt.ProductionStmt;
import net.bigers.funeralsystem.fune0000.domain.production_stmt.ProductionStmtService;
import net.bigers.funeralsystem.fune0000.domain.recipe.RecipeService;
import net.bigers.funeralsystem.fune0000.domain.user_mng_part.UserMngPartService;

@Controller
public class FUNE4070Controller extends BaseController{
	
	@Inject
	private UserMngPartService userMngPartService;
	@Autowired
	private ItemGroupService itemGroupService;
	@Autowired
	RecipeService recipeService;
	@Autowired
	private ItemService itemService;

	/**
	 * 검색 콤보 파트 목록 취득
	 */
	@ApiOperation(value = "검색파트", notes = "검색파트")
	@RequestMapping(value="/FUNE4070/part", method={RequestMethod.POST}, produces=APPLICATION_JSON) // POST 방식을 사용하였는데, AXSearch 컴포넌트에서 AJAX 요청시 GET 방식으로 받아오지 않기에 POST방식으로 사용하였다.
	public CommonListResponseParams.ListResponse getPartList(){
		List<Part> list =  this.userMngPartService.getByCurrentUser();
		return CommonListResponseParams.ListResponse.of(list);
	}
	
	/**
	 * 우측 콤보 정보 취득
	 * @param String partCode
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "품목그룹", notes = "품목그룹")
	@RequestMapping(value="/FUNE4070/recipe/itemGroup" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse getItemGroup(String partCode) throws Exception{
		List<ItemGroup> resList = this.itemGroupService.findByPartCodeOrderByGroupCode(partCode);		
		return ListResponse.of(resList);
	}
	
	/**
	 * 생산제품 콤보 정보 취득
	 * @param String partCode
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "생산제품", notes = "생산제품")
	@RequestMapping(value="/FUNE4070/item" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public CommonListResponseParams.ListResponse getItemProduct(String partCode) throws Exception{
		List<Object[]> getList = this.recipeService.getHistoryGoods(partCode);
		List<OptionVTO> list = new ArrayList<OptionVTO>();
		for(int i=0;i<getList.size();i++){
			Object[] k = getList.get(i);
			list.add(OptionVTO.of(k[0].toString(), k[1].toString()));
		}
		
		return CommonListResponseParams.ListResponse.of(list);
	}
	
	/**
	 * 좌측 검색 그리드 1 아이템 목록 취득
	 * @param requestBody
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "아이템 목록", notes = "아이템 목록")
	@RequestMapping(value="/FUNE4070/recipe/item" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public CommonListResponseParams.ListResponse findItem(@RequestParam Map<String, String> requestBody) throws Exception{
		String partCode 	= requestBody.get("partCode");
		String groupCode 	= requestBody.get("groupCode");
		String itemCode 	= requestBody.get("itemCode");
		String itemName 	= requestBody.get("itemName");
		List<Item> list = itemService.findByItemItemCodeStartingWithAndItemNameAndItemKindCode(
				partCode, groupCode, itemCode, itemName, "60"
		);		
		return CommonListResponseParams.ListResponse.of(list);
	}
	
}
