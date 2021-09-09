/*****************************************************************************
 * 프로그램명  : FUNE3014Controller.java
 * 설     명  : 매입관리 > 실사재고 팝업 처리 컨트롤러
 * 참고  사항  : 없음
 *****************************************************************************
 * Date       Author  Version Description
 * ---------- ------- ------- -----------------------------------------------
 * 2017.11.13  KYM    1.0     초기작성
 *****************************************************************************/
package net.bigers.funeralsystem.fune0000.fune3000;


import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroupService;
import net.bigers.funeralsystem.fune0000.domain.stock.StockService;
import net.bigers.funeralsystem.fune0000.domain.stock_real.StockRealService;
import net.bigers.funeralsystem.fune0000.vto.StockRealVTO;
import net.bigers.funeralsystem.fune0000.vto.StockVTO;
import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.lib.util.MapUtils.MapItem;

@Controller
public class FUNE3014Controller extends BaseController{

	@Autowired
	private StockService stockService;

	@Autowired
	private StockRealService stockRealService;

	@Autowired
	private ItemGroupService itemGroupService;



	/**
	 * 우측 콤보 정보 취득
	 * @param String partCode
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "품목그룹", notes = "품목그룹")
	@RequestMapping(value="/FUNE3014/real/itemGroup" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse getItemGroup(String partCode) throws Exception{
		return ListResponse.of(this.itemGroupService.findBuyPartCode(partCode));
	}


	/**
	 * 재고 목록 취득
	 * @param String partCode
	 * 	@param String groupCode
	 * @param String itemName
	 * @param String jobYm
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "재고 목록", notes = "재고 목록")
	@RequestMapping(value="/FUNE3014/stock" , method= RequestMethod.GET, produces=APPLICATION_JSON )
//	public List<Object[]> getStock(String partCode, String groupCode, String itemName, String jobYm) throws Exception{
	public List<StockVTO> getStock(StockVTO stockVTO) throws Exception{
		return this.stockService.findStock(stockVTO);
	}

	/**
	 * 실사 재고 요약 목록 취득
	 * @param String partCode
	 * @param String jobYm
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "실사 재고 요약 목록", notes = "실사 재고 요약 목록")
	@RequestMapping(value="/FUNE3014/stockRealSummary" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public List<Object[]> getStockRealSummary(String partCode, String jobYm) throws Exception{
		return this.stockRealService.findStockRealSummary(partCode, jobYm);
	}

	/**
	 * 실사 재고 목록 취득
	 * @param String partCode
	 * @param String etDate
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "실사 재고 목록", notes = "실사 재고 목록")
	@RequestMapping(value="/FUNE3014/stockReal" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse getStockReal(String partCode, @DateTimeFormat(pattern="yyyy-MM-dd") Date etDate) throws Exception{
		return ListResponse.of(this.stockRealService.findStockReal(partCode, etDate));
	}

	/**
	 * 실사 재고 저장
	 * @param StockRealVTO
	 * @exception Exception 시스템예외
	 */
	@ApiOperation(value = "실사 재고 저장", notes = "실사 재고 저장")
	@RequestMapping(value="/FUNE3014/stockReal" , method= RequestMethod.POST, produces=APPLICATION_JSON )
	public MapResponse saveStockReal(@RequestBody StockRealVTO stockRealVTO) throws Exception{
		return MapResponse.of(MapUtils.getMap(MapItem.of("stockReal", this.stockRealService.saveStockReal(stockRealVTO))));
	}
}
