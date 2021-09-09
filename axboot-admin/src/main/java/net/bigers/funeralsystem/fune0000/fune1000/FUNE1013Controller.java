package net.bigers.funeralsystem.fune0000.fune1000;

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

import net.bigers.funeralsystem.fune0000.domain.funeral.FuneralService;
import net.bigers.funeralsystem.fune0000.domain.item.ItemId;
import net.bigers.funeralsystem.fune0000.domain.item.ItemService;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt.SaleStmt;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt.SaleStmtService;
import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.lib.util.MapUtils.MapItem;

@Controller
public class FUNE1013Controller extends BaseController {

	@Autowired
	private SaleStmtService saleStmtService;

	@ApiOperation(value = "반납대상품목", notes = "반납대상품목")
	@RequestMapping(value="/FUNE1013/return/item" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse getFuneral(String customerNo, String partCode) throws Exception{

		return ListResponse.of(this.saleStmtService.findReturnItem(customerNo, partCode));
	}

}
