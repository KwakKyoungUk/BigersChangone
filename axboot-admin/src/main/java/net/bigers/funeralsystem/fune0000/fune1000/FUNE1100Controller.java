package net.bigers.funeralsystem.fune0000.fune1000;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

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

import net.bigers.funeralsystem.common.vto.OptionVTO;
import net.bigers.funeralsystem.fune0000.domain.item_group.ItemGroupService;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt.SaleStmt;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt.SaleStmtId;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt.SaleStmtService;
import net.bigers.funeralsystem.fune0000.domain.user_mng_part.UserMngPartService;
import net.bigers.funeralsystem.fune0000.vto.SaleStmtCancelVTO;
import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.lib.util.MapUtils.MapItem;

@Controller
public class FUNE1100Controller extends BaseController {

	@Autowired
	private PartService partService;

	@Autowired
	private SaleStmtService saleStmtService;

	@Autowired
	private ItemGroupService itemGroupService;

	@Autowired
	private UserMngPartService userMngPartService;

	@ApiOperation(value = "파트", notes = "파트")
	@RequestMapping(value="/FUNE1100/part/all" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse getPartAll() throws Exception{

		return ListResponse.of(this.userMngPartService.getByCurrentUser());
	}

	@ApiOperation(value = "전표", notes = "전표")
	@RequestMapping(value="/FUNE1100/saleStmt" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse getSaleStmt(
			String partCode
			, @RequestParam(required=false, defaultValue="") String jungsanKind
			, @DateTimeFormat(pattern="yyyy-MM-dd") Date etDate
			) throws Exception{

		return ListResponse.of(this.saleStmtService.findEachStmt(partCode, jungsanKind, etDate));
	}

	@ApiOperation(value = "전표삭제", notes = "전표삭제")
	@RequestMapping(value="/FUNE1100/saleStmt" , method= RequestMethod.DELETE, produces=APPLICATION_JSON )
	public ApiResponse deleteSaleStmt(
			String customerNo
			, String partCode
			, Integer billNo
			) throws Exception{

		this.saleStmtService.deleteSaleStmt(this.saleStmtService.findOne(SaleStmtId.of(customerNo, partCode, billNo)));
		return ok();
	}

	@ApiOperation(value = "품목 그룹", notes = "품목 그룹")
	@RequestMapping(value="/FUNE1100/itemGroup/option" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public List<OptionVTO> getItemGroupOption() throws Exception{

		return this.itemGroupService.findAll().stream().map(ig->OptionVTO.of(ig.getGroupCode(), ig.getGroupName())).collect(Collectors.toList());
	}

	@ApiOperation(value = "승인취소", notes = "승인취소")
	@RequestMapping(value="/FUNE1100/saleStmt" , method= RequestMethod.POST, produces=APPLICATION_JSON )
	public MapResponse saveSaleStmt(@RequestBody SaleStmtCancelVTO saleStmt) throws Exception{

		return MapResponse.of(MapUtils.getMap(MapItem.of("saleStmt", this.saleStmtService.saveSaleStmt(saleStmt))));
	}

}
