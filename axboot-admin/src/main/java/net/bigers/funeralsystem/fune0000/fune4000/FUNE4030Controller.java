/*****************************************************************************
 * 프로그램명  : FUNE4030Controller.java
 * 설     명  : 생산전표내역 처리 컨트롤러
 * 참고  사항  : 없음
 *****************************************************************************
 * Date       Author  Version Description
 * ---------- ------- ------- -----------------------------------------------
 * 2017.11.27  KYM    1.0     초기작성
 *****************************************************************************/
package net.bigers.funeralsystem.fune0000.fune4000;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;

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
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.fune0000.domain.production_stmt.ProductionStmt;
import net.bigers.funeralsystem.fune0000.domain.production_stmt.ProductionStmtService;
import net.bigers.funeralsystem.fune0000.domain.user_mng_part.UserMngPartService;

@Controller
public class FUNE4030Controller extends BaseController{
	
	@Inject
	private UserMngPartService userMngPartService;
	@Inject
	private ProductionStmtService productionStmtService;

	/**
	 * 검색 콤보 파트 목록 취득
	 */
	@ApiOperation(value = "검색파트", notes = "검색파트")
	@RequestMapping(value="/FUNE4030/part", method={RequestMethod.POST}, produces=APPLICATION_JSON) // POST 방식을 사용하였는데, AXSearch 컴포넌트에서 AJAX 요청시 GET 방식으로 받아오지 않기에 POST방식으로 사용하였다.
	public CommonListResponseParams.ListResponse getPartList(){
		List<Part> list =  this.userMngPartService.getByCurrentUser();
		return CommonListResponseParams.ListResponse.of(list);
	}
		
	/**
	 * 생산 전표 목록 취득
	 * @param request Request객체
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "생산 전표 조회", notes = "생산 전표 조회")
	@RequestMapping(value="/FUNE4030/productionStmt" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public List<Object[]> getBuyStmtList(@RequestParam Map<String, String> requestBody) throws Exception{		
		List<Object[]> productionStmtList = productionStmtService.findProductionStmtList(requestBody);		
		return productionStmtList;
	}
}
