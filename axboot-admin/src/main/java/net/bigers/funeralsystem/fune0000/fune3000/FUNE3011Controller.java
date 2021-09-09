/*****************************************************************************
 * 프로그램명  : FUNE3011Controller.java
 * 설     명  : 매입관리 > 등록 , 수정 팝업 처리 컨트롤러
 * 참고  사항  : 없음
 *****************************************************************************
 * Date       Author  Version Description
 * ---------- ------- ------- -----------------------------------------------
 * 2017.11.02  KYM    1.0     초기작성
 *****************************************************************************/
package net.bigers.funeralsystem.fune0000.fune3000;


import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.fune0000.domain.buy_stmt.BuyStmt;
import net.bigers.funeralsystem.fune0000.domain.buy_stmt.BuyStmtService;
import net.bigers.funeralsystem.fune0000.domain.buy_stmt_bd.BuyStmtBdService;
import net.bigers.funeralsystem.fune0000.domain.item.ItemService;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroupService;
import net.bigers.funeralsystem.fune0000.vto.BuyStmtVTO;
import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.lib.util.MapUtils.MapItem;

@Controller
public class FUNE3011Controller extends BaseController{

	@Autowired
	private BuyStmtService buyStmtService;
	@Autowired
	BuyStmtBdService buyStmtBdService;
	@Autowired
	private ItemService itemService;
	@Autowired
	private ItemGroupService itemGroupService;

	/**
	 * 좌측 상단 정보 취득
	 * @param String partCode
	 * @param String custCode
	 * @param String etDate
	 * @param Integer billNo
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "매입전표 등록 상단 메인 정보", notes = "매입전표 등록 상단 메인 정보")
	@RequestMapping(value="/FUNE3011/buyStmtBd" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public MapResponse getBuyStmtBdDef(String partCode, String custCode, @DateTimeFormat(pattern="yyyy-MM-dd") Date etDate, Integer billNo) throws Exception{
		return MapResponse.of(MapUtils.getMap(MapItem.of("buyStmtBd", this.buyStmtBdService.getBuyStmtBdDef(partCode, custCode, etDate, billNo))));
	}

	/**
	 * 우측 콤보 정보 취득
	 * @param String partCode
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "품목그룹", notes = "품목그룹")
	@RequestMapping(value="/FUNE3011/buy/itemGroup" , method= RequestMethod.GET, produces=APPLICATION_JSON )
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
	@RequestMapping(value="/FUNE3011/buy/item" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse getBuyItem(String partCode, String custCode, String groupCode, String itemName) throws Exception{
		return ListResponse.of(this.itemService.findBuyItem(partCode, custCode, groupCode, itemName));
	}

	/**
	 * 매입 전표 저장
	 * @param BuyStmtVTO
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "매입전표저장", notes = "메입전표저장")
	@RequestMapping(value="/FUNE3011/buyStmt" , method= RequestMethod.POST, produces=APPLICATION_JSON )
	public MapResponse saveBuyStmt(@RequestBody BuyStmtVTO buyStmtVTO) throws Exception{
		return MapResponse.of(MapUtils.getMap(MapItem.of("buyStmt", this.buyStmtService.saveBuyStmt(buyStmtVTO))));
	}

	/**
	 * 매입 전표 삭제
	 * @param BuyStmt
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = " 매입전표삭제", notes = "매입전표삭제")
	@RequestMapping(value="/FUNE3011/buyStmt" , method= RequestMethod.DELETE, produces=APPLICATION_JSON )
	public ApiResponse deleteBuyStmt(@RequestBody BuyStmt buyStmt) throws Exception{

		this.buyStmtService.deleteBuyStmt(buyStmt);

		return ok();
	}
}
