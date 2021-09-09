/*****************************************************************************
 * 프로그램명  : FUNE4020Controller.java
 * 설     명  : 식단 관리 처리 컨트롤러
 * 참고  사항  : 없음
 *****************************************************************************
 * Date       Author  Version Description
 * ---------- ------- ------- -----------------------------------------------
 * 2017.11.08  KYM    1.0     초기작성
 *****************************************************************************/
package net.bigers.funeralsystem.fune0000.fune4000;

import java.util.List;
import javax.inject.Inject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.wordnik.swagger.annotations.ApiOperation;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.fune0000.domain.recipe.RecipeService;

@Controller
public class FUNE4020Controller extends BaseController{
	
	@Inject
	private PartService partService;
	@Autowired
	RecipeService recipeService;

	/**
	 * 검색 콤보 파트 목록 취득
	 */
	@ApiOperation(value = "검색파트", notes = "검색파트")
	@RequestMapping(value="/FUNE4020/part", method={RequestMethod.POST}, produces=APPLICATION_JSON) // POST 방식을 사용하였는데, AXSearch 컴포넌트에서 AJAX 요청시 GET 방식으로 받아오지 않기에 POST방식으로 사용하였다.
	public CommonListResponseParams.ListResponse getPartList(String partGroupCode){
		List<Part> list =  partService.findByPartGroupCodeOrderByPartCodeAsc(partGroupCode);
		return CommonListResponseParams.ListResponse.of(list);
	}
		
	/**
	 * 식단 관리 달력 데이타 조회
	 * @param String partCode
	 * @param String recipeYm
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "식단 관리 달력 데이타 조회", notes = "식단 관리 달력 데이타 조회")
	@RequestMapping(value="/FUNE4020/recipeCal" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public List<Object[]> getBuyStmtList(String partCode, String recipeYm) throws Exception{
		recipeYm = recipeYm.replace("-","");
		List<Object[]> recipeCalendarList = recipeService.findRecipeCalendarList(partCode, recipeYm);		
		return recipeCalendarList;
	}
}
