/*****************************************************************************
 * 프로그램명  : FUNE3010Controller.java
 * 설     명  : 매입관리 처리 컨트롤러
 * 참고  사항  : 없음
 *****************************************************************************
 * Date       Author  Version Description
 * ---------- ------- ------- -----------------------------------------------
 * 2017.10.30  KYM    1.0     초기작성
 *****************************************************************************/
package net.bigers.funeralsystem.fune0000.fune3000;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.fune0000.domain.buy_stmt.BuyStmtService;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.stock.StockService;
import net.bigers.funeralsystem.fune0000.domain.user_mng_part.UserMngPartService;

@Controller
public class FUNE3010Controller extends BaseController{

	@Inject
	private BuyStmtService buyStmtService;

	@Autowired
	private StockService stockService;

	@Inject
	private UserMngPartService userMngPartService;

	@RequestMapping(value="/FUNE3010/part", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getPart(){
		List<Part> list = userMngPartService.getByCurrentUser();
		return CommonListResponseParams.ListResponse.of(list);
	}

	/**
	 * 거래처 그리드 목록 취득
	 * @param request Request객체
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "거래처 조회", notes = "거래처 조회")
	@RequestMapping(value="/FUNE3010/customer/list" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public List<Object[]> getBuyStmtList(@RequestParam Map<String, String> requestBody) throws Exception{
		List<Object[]> buyStmtList = buyStmtService.findBuyStmtList(requestBody);
		return buyStmtList;
	}

	/**
	 * 전표 그리드 목록 취득
	 * @param request Request객체
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "전표 조회", notes = "전표 조회")
	@RequestMapping(value="/FUNE3010/customer/bill_list" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public List<Object[]> getBuyStmtBillList(@RequestParam Map<String, String> requestBody) throws Exception{
		List<Object[]> buyStmtList = buyStmtService.findBuyStmtListRemark(requestBody);
		return buyStmtList;
	}

	/**
	 * 재고자료정리
	 * @param request Request객체
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "재고자료정리", notes = "재고자료정리")
	@RequestMapping(value="/FUNE3010/stock/arrange" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ApiResponse arrangeStockData(String workDate) throws Exception{
		this.stockService.arrangeStock(workDate);
		return ok();
	}


}
