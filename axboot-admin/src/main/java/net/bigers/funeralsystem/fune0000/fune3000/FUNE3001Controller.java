/*****************************************************************************
 * 프로그램명  : FUNE3001Controller.java
 * 설     명  : 매입목록관리 처리 컨트롤러
 * 참고  사항  : 없음
 *****************************************************************************
 * Date       Author  Version Description
 * ---------- ------- ------- -----------------------------------------------
 * 2021.01.26  HJ    1.0     초기작성
 *****************************************************************************/
package net.bigers.funeralsystem.fune0000.fune3000;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.domain.user.UserService;
import com.axisj.axboot.core.util.DozerBeanMapperUtils;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.fune0000.domain.buy_list.BuyList;
import net.bigers.funeralsystem.fune0000.domain.buy_list.BuyListService;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.stock.StockService;
import net.bigers.funeralsystem.fune0000.domain.user_mng_part.UserMngPartService;
import net.bigers.funeralsystem.fune0000.vto.BuyListVTO;

@Controller
public class FUNE3001Controller extends BaseController{

	@Inject
	private BuyListService BuyListService;

	@Autowired
	private StockService stockService;

	@Inject
	private UserMngPartService userMngPartService;

	@Autowired
	private UserService userService;

	@RequestMapping(value="/FUNE3001/part", method={RequestMethod.POST}, produces=APPLICATION_JSON)
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
	@RequestMapping(value="/FUNE3001/customer/list" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public List<Object[]> getBuyListList(@RequestParam Map<String, String> requestBody) throws Exception{
		List<Object[]> BuyListList = BuyListService.findBuyListList(requestBody);
		return BuyListList;
	}

	/**
	 * 전표 그리드 목록 취득
	 * @param request Request객체
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "전표 조회", notes = "전표 조회")
	@RequestMapping(value="/FUNE3001/customer/bill_list" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public List<BuyListVTO> getBuyListBillList(String partCode, String custCode, @DateTimeFormat(pattern="yyyy-MM-dd") Date regDate) throws Exception{
		List<BuyList> BuyListList = BuyListService.findBuyListListRemark(partCode, custCode, regDate);
		List<BuyListVTO> res = DozerBeanMapperUtils.mapList(BuyListList, BuyListVTO.class);
		return res.stream().map(o->{
			try {
				o.setUserNm(this.userService.findOne(o.getUdtid()).getUserNm());
			} catch (Exception e) {
				o.setUserNm("");
			}
			return o;
		}).collect(Collectors.toList());
	}

	/**
	 * 재고자료정리
	 * @param request Request객체
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "재고자료정리", notes = "재고자료정리")
	@RequestMapping(value="/FUNE3001/stock/arrange" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ApiResponse arrangeStockData(String workDate) throws Exception{
		this.stockService.arrangeStock(workDate);
		return ok();
	}


}
