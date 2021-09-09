/*****************************************************************************
 * 프로그램명  : FUNE3011Controller.java
 * 설     명  : 생산관리 > 등록 , 수정 팝업 처리 컨트롤러
 * 참고  사항  : 없음
 *****************************************************************************
 * Date       Author  Version Description
 * ---------- ------- ------- -----------------------------------------------
 * 2017.11.02  KYM    1.0     초기작성
 *****************************************************************************/
package net.bigers.funeralsystem.fune0000.fune4000;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.fune0000.domain.item.ItemService;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroup;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroupService;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.fune0000.domain.production_stmt.ProductionStmt;
import net.bigers.funeralsystem.fune0000.domain.production_stmt.ProductionStmtService;
import net.bigers.funeralsystem.fune0000.domain.production_stmt_bd.ProductionStmtBdService;
import net.bigers.funeralsystem.fune0000.domain.recipe.RecipeService;
import net.bigers.funeralsystem.fune0000.vto.ProductionStmtVTO;
import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.lib.util.MapUtils.MapItem;

@Controller
public class FUNE4011Controller extends BaseController{

	@Autowired
	private ProductionStmtService productionStmtService;
	@Autowired
	ProductionStmtBdService productionStmtBdService;
	@Autowired
	private ItemGroupService itemGroupService;
	@Autowired
	RecipeService recipeService;


	/**
	 * 좌측 상단 정보 취득
	 * @param String partCode
	 * @param String custCode
	 * @param Date etDate
	 * @param Integer billNo
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "생산전표 등록 상단 메인 정보", notes = "생산전표 등록 상단 메인 정보")
	@RequestMapping(value="/FUNE4011/productionStmtBd" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public MapResponse getBuyStmtBdDef(String partCode, String custCode, @DateTimeFormat(pattern="yyyy-MM-dd") Date etDate, Integer billNo) throws Exception{
		return MapResponse.of(MapUtils.getMap(MapItem.of("productionStmtBd", this.productionStmtBdService.getProductionStmtBdDef(partCode, etDate, billNo))));
	}

	/**
	 * 우측 콤보 정보 취득
	 * @param String partCode
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "품목그룹", notes = "품목그룹")
	@RequestMapping(value="/FUNE4011/recipe/itemGroup" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse getItemGroup(String partCode) throws Exception{
		List<ItemGroup> resList = this.itemGroupService.findByPartCodeOrderByGroupCode(partCode);
		ItemGroup itemGroup = new ItemGroup();
		itemGroup.setPartCode(partCode);
		itemGroup.setGroupCode("999999");
		itemGroup.setGroupName("식단(미생산)");
		resList.add(itemGroup);

		return ListResponse.of(resList);
	}

	/**
	 * 레시피 목록 취득
	 * @param String partCode
	 * 	@param String groupCode
	 * @param String itemName
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "레시피목록", notes = "레시피목록")
	@RequestMapping(value="/FUNE4011/recipe/item" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public List<Object[]> findRecipeItem(@RequestParam Map<String, String> requestBody) throws Exception{
		return this.recipeService.findRecipeItem(requestBody);
	}

	/**
	 * 생산 전표 저장
	 * @param ProductionStmtVTO
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "생산전표저장", notes = "생산전표저장")
	@RequestMapping(value="/FUNE4011/productionStmt" , method= RequestMethod.POST, produces=APPLICATION_JSON )
	public MapResponse saveBuyStmt(@RequestBody ProductionStmtVTO productionStmtVTO) throws Exception{
		System.out.println("CONTROLLER=" + productionStmtVTO.getBillNo() + " ^^^^^^ "+ productionStmtVTO.toString());
		return MapResponse.of(MapUtils.getMap(MapItem.of("productionStmt", this.productionStmtService.saveProductionStmt(productionStmtVTO))));
	}

	/**
	 * 생산 전표 삭제
	 * @param ProductionStmt
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = " 매입전표삭제", notes = "매입전표삭제")
	@RequestMapping(value="/FUNE4011/productionStmt" , method= RequestMethod.DELETE, produces=APPLICATION_JSON )
	public ApiResponse deleteProductionStmt(@RequestBody ProductionStmt productionStmt) throws Exception{

		this.productionStmtService.deleteProductionStmt(productionStmt);

		return ok();
	}
}
