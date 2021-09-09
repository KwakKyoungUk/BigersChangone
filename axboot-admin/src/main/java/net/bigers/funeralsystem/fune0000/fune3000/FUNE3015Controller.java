/*****************************************************************************
 * 프로그램명  : FUNE3015Controller.java
 * 설     명  : 매입목록관리 > 등록 , 수정 팝업 처리 컨트롤러
 * 참고  사항  : 없음
 *****************************************************************************
 * Date       Author  Version Description
 * ---------- ------- ------- -----------------------------------------------
 * 2021.01.31   HJ    1.0     초기작성
 *****************************************************************************/
package net.bigers.funeralsystem.fune0000.fune3000;


import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.fune0000.domain.buy_list.BuyList;
import net.bigers.funeralsystem.fune0000.domain.buy_list.BuyListService;
import net.bigers.funeralsystem.fune0000.domain.buy_list_bd.BuyListBdService;
import net.bigers.funeralsystem.fune0000.domain.customer.Customer;
import net.bigers.funeralsystem.fune0000.domain.item.ItemService;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroupService;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.user_mng_part.UserMngPartService;
import net.bigers.funeralsystem.fune0000.vto.BuyListVTO;
import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.lib.util.MapUtils.MapItem;

@Controller
public class FUNE3015Controller extends BaseController{

	@Autowired
	private BuyListService buyListService;
	@Autowired
	BuyListBdService buyListBdService;
	@Autowired
	private ItemService itemService;
	@Autowired
	private ItemGroupService itemGroupService;


	/**
	 * 좌측 상단 정보 취득
	 * @param String partCode
	 * @param String custCode
	 * @param String regDate
	 * @param Integer listNo
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "매입전표 등록 상단 메인 정보", notes = "매입전표 등록 상단 메인 정보")
	@RequestMapping(value="/FUNE3015/buyListBd" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public MapResponse getBuyListBdDef(String partCode, String custCode, @DateTimeFormat(pattern="yyyy-MM-dd") Date regDate, Integer listNo) throws Exception{
		return MapResponse.of(MapUtils.getMap(MapItem.of("buyListBd", this.buyListBdService.getBuyListBdDef(partCode, custCode, regDate, listNo))));
	}

	/**
	 * 전표 그리드 목록 취득
	 * @param request Request객체
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "전표 조회", notes = "전표 조회")
	@RequestMapping(value="/FUNE3015/customer/bill_list" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse getBuyListBillList(String partCode, String custCode, @DateTimeFormat(pattern="yyyy-MM-dd") Date regDate) throws Exception{
		List<BuyList> buyList = buyListService.findBuyListListRemark(partCode, custCode, regDate);
		return ListResponse.of(buyList);
	}

	/**
	 * 전표 내용 그리드 목록 취득
	 * @param request Request객체
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "전표 내용 조회", notes = "전표 내용 조회")
	@RequestMapping(value="/FUNE3015/customer/list" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public List<Object[]> getBuyListBdList(@RequestParam Map<String, String> requestBody) throws Exception{
		List<Object[]> BuybdList = buyListBdService.findBuybdList(requestBody);
		return BuybdList;
	}

	/**
	 * 우측 콤보 정보 취득
	 * @param String partCode
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "품목그룹", notes = "품목그룹")
	@RequestMapping(value="/FUNE3015/buy/itemGroup" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse getItemGroup(String partCode, String custCode) throws Exception{
		return ListResponse.of(this.itemGroupService.findBuyPartCode(partCode, custCode));
	}

	/**
	 * 품목 목록 취득
	 * @param String partCode
	 * 	@param String groupCode
	 * @param String itemName
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "품목목록", notes = "품목목록")
	@RequestMapping(value="/FUNE3015/buy/item" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse getBuyItem(String partCode, String custCode, String groupCode, String itemName) throws Exception{
		return ListResponse.of(this.itemService.findBuyItem(partCode, custCode, groupCode, itemName));
	}

	/**
	 * 매입 전표 저장
	 * @param BuyListVTO
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "매입목록저장", notes = "메입목록저장")
	@RequestMapping(value="/FUNE3015/buyList" , method= RequestMethod.POST, produces=APPLICATION_JSON )
	public MapResponse saveBuyList(@RequestBody BuyListVTO buyListVTO) throws Exception{
		return MapResponse.of(MapUtils.getMap(MapItem.of("buyList", this.buyListService.saveBuyList(buyListVTO))));
	}

	/**
	 * 매입 전표 삭제
	 * @param BuyList
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = " 매입목록삭제", notes = "매입목록삭제")
	@RequestMapping(value="/FUNE3015/buyList" , method= RequestMethod.DELETE, produces=APPLICATION_JSON )
	public ApiResponse deleteBuyList(@RequestBody BuyList buyList) throws Exception{

		this.buyListService.deleteBuyList(buyList);

		return ok();
	}
}
