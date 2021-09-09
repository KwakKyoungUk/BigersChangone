package net.bigers.funeralsystem.fune0000.fune1000;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.common.vto.OptionVTO;
import net.bigers.funeralsystem.fune0000.domain.binso.BinsoService;
import net.bigers.funeralsystem.fune0000.domain.funeral.FuneralService;
import net.bigers.funeralsystem.fune0000.domain.item.Item;
import net.bigers.funeralsystem.fune0000.domain.item.ItemId;
import net.bigers.funeralsystem.fune0000.domain.item.ItemService;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroupService;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt.SaleStmt;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt.SaleStmtService;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt_bd.SaleStmtBd;
import net.bigers.funeralsystem.fune0000.domain.set_group.SetGroupService;
import net.bigers.funeralsystem.fune0000.domain.stock.StockService;
import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.lib.util.MapUtils.MapItem;

@Controller
public class FUNE1012Controller extends BaseController {

	@Autowired
	private FuneralService funeralService;

	@Autowired
	private ItemService itemService;

	@Autowired
	private ItemGroupService itemGroupService;

	@Autowired
	private PartService partService;

	@Autowired
	private BinsoService binsoService;

	@Autowired
	private SaleStmtService saleStmtService;

	@Autowired
	private SetGroupService setGroupService;

	@Autowired
	private StockService stockService;

	@ApiOperation(value = "고인정보", notes = "고인정보")
	@RequestMapping(value="/FUNE1012/funeral" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public MapResponse getFuneral(String customerNo) throws Exception{

		return MapResponse.of(MapUtils.getMap(MapItem.of("funeral", this.funeralService.findOne(customerNo))));
	}

	@ApiOperation(value = "품목", notes = "품목")
	@RequestMapping(value="/FUNE1012/item" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public MapResponse getItem(ItemId id) throws Exception{
		Item item = this.itemService.getItem(id);
		Map<String, Object> res = new HashMap<>();
		res.put("item", item);
		if(Objects.nonNull(item)){
			res.put("isBarCode", !item.getItemCode().equals(id.getItemCode()));
		}
		return MapResponse.of(res);
	}

	@ApiOperation(value = "품목", notes = "품목")
	@RequestMapping(value="/FUNE1012/sale/item" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse getSaleItem(String partCode, String groupCode, String itemName) throws Exception{

		return ListResponse.of(this.itemService.findSaleItem(partCode, groupCode, itemName));
	}

	@ApiOperation(value = "품목", notes = "품목")
	@RequestMapping(value="/FUNE1012/sale/set-group" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse getSaleItem(String partCode, String itemName) throws Exception{

		return ListResponse.of(this.setGroupService.findByPartCodeAndSetNameStartingWith(partCode, itemName));
	}

	@ApiOperation(value = "파트", notes = "파트")
	@RequestMapping(value="/FUNE1012/part" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public MapResponse getPart(String partCode) throws Exception{

		return MapResponse.of(MapUtils.getMap(MapItem.of("part", this.partService.findOne(partCode))));
	}

	@ApiOperation(value = "전표", notes = "전표")
	@RequestMapping(value="/FUNE1012/saleStmt" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse getSaleStmt(String customerNo, String partCode) throws Exception{

		return ListResponse.of(this.saleStmtService.findByCustomerNoAndPartCode(customerNo, partCode));
	}

	@ApiOperation(value = "전표저장", notes = "전표저장")
	@RequestMapping(value="/FUNE1012/saleStmt" , method= RequestMethod.POST, produces=APPLICATION_JSON )
	public MapResponse saveSaleStmt(@RequestBody SaleStmt saleStmt) throws Exception{

		SaleStmt ss = this.saleStmtService.saveSaleStmt(saleStmt);

		Map<String, Object> res = MapUtils.getMap("saleStmt", ss);

		List<SaleStmt> ssAll = this.saleStmtService.findByCustomerNoAndPartCode(ss.getCustomerNo(), ss.getPartCode());

		res.put("saleStmtAll", ssAll);
		res.put("stmt", ss);

		return MapResponse.of(res);
	}

	@ApiOperation(value = "전표삭제", notes = "전표삭제")
	@RequestMapping(value="/FUNE1012/saleStmt" , method= RequestMethod.DELETE, produces=APPLICATION_JSON )
	public ApiResponse deleteSaleStmt(@RequestBody SaleStmt saleStmt) throws Exception{

		this.saleStmtService.deleteSaleStmt(saleStmt);

		return ok();
	}

	@ApiOperation(value = "품목그룹", notes = "품목그룹")
	@RequestMapping(value="/FUNE1012/sale/itemGroup" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse getItemGroup(String partCode) throws Exception{

		List<OptionVTO> options = this.itemGroupService.findSalePartCode(partCode).stream().map(ig->OptionVTO.of(ig.getGroupCode(), ig.getGroupName())).collect(Collectors.toList());
		options.add(OptionVTO.of("set", "세트품목"));
		return ListResponse.of(options);
	}

	@ApiOperation(value = "개별판매", notes = "개별판매")
	@RequestMapping(value="/FUNE1012/eachSale/funeral" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public MapResponse getEachSaleFuneral(String customerNo, String partCode) throws Exception{

		return MapResponse.of(MapUtils.getMap(MapItem.of("funeral", this.funeralService.getEachSaleFuneral(customerNo, partCode))));
	}

	@RequestMapping(value="/FUNE1012/is-sell" , method= RequestMethod.POST, produces=APPLICATION_JSON )
	public Object isSell(@RequestBody List<SaleStmtBd> saleStmtBds) throws Exception{

		return this.stockService.isSell(saleStmtBds);
	}


}
