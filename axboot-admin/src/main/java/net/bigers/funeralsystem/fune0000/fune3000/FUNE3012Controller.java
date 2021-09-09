/*****************************************************************************
 * 프로그램명  : FUNE3012Controller.java
 * 설     명  : 매입거래명세서 처리 컨트롤러
 * 참고  사항  : 없음
 *****************************************************************************
 * Date       Author  Version Description
 * ---------- ------- ------- -----------------------------------------------
 * 2017.11.29  KYM    1.0     초기작성
 *****************************************************************************/
package net.bigers.funeralsystem.fune0000.fune3000;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.wordnik.swagger.annotations.ApiOperation;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.fune0000.domain.user_mng_part.UserMngPartService;
import net.bigers.funeralsystem.common.vto.OptionVTO;
import net.bigers.funeralsystem.fune0000.domain.buy_stmt.BuyStmtService;

@Controller
public class FUNE3012Controller extends BaseController{
	
	@Inject
	private BuyStmtService buyStmtService;
	@Inject
	private UserMngPartService userMngPartService;
	/**
	 * 검색 콤보 파트 목록 취득
	 */
	@ApiOperation(value = "검색파트", notes = "검색파트")
	@RequestMapping(value="/FUNE3012/part", method={RequestMethod.POST}, produces=APPLICATION_JSON) // POST 방식을 사용하였는데, AXSearch 컴포넌트에서 AJAX 요청시 GET 방식으로 받아오지 않기에 POST방식으로 사용하였다.
	public CommonListResponseParams.ListResponse getPartList(){
		List<Part> list =  this.userMngPartService.getByCurrentUser();
		return CommonListResponseParams.ListResponse.of(list);
	}
		
	/**
	 * 거래처 콤보 목록 취득
	 * @param request Request객체
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "거래처 조회", notes = "거래처 조회")
	@RequestMapping(value="/FUNE3012/customer/list" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public CommonListResponseParams.ListResponse getBuyStmtList(@RequestParam Map<String, String> requestBody) throws Exception{		
		List<Object[]> buyStmtList = buyStmtService.findBuyStmtList(requestBody);
		List<OptionVTO> list = new ArrayList<OptionVTO>();
		for(int i=0;i<buyStmtList.size();i++){
			Object[] k = buyStmtList.get(i);
			list.add(OptionVTO.of(k[1].toString(), k[2].toString()));
		}
		return CommonListResponseParams.ListResponse.of(list);
	}
	
	/**
	 * 전표 그리드 목록 취득
	 * @param request Request객체
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "전표 조회", notes = "전표 조회")
	@RequestMapping(value="/FUNE3012/customer/bill_list" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public List<Object[]> getBuyStmtBillList(@RequestParam Map<String, String> requestBody) throws Exception{
		List<Object[]> buyStmtList = buyStmtService.findBuyStmtListRemarkdetail(requestBody);		
		return buyStmtList;
	}

	

}
