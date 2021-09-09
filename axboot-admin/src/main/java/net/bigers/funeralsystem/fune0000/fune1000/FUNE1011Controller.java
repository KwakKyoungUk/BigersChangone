package net.bigers.funeralsystem.fune0000.fune1000;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.fune0000.domain.binso_assign.BinsoAssign;
import net.bigers.funeralsystem.fune0000.domain.binso_assign.BinsoAssignId;
import net.bigers.funeralsystem.fune0000.domain.binso_assign.BinsoAssignService;
import net.bigers.funeralsystem.fune0000.domain.funeral.FuneralService;
import net.bigers.funeralsystem.fune0000.domain.funeral.Part;
import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.lib.util.MapUtils.MapItem;

@Controller
public class FUNE1011Controller extends BaseController {

	@Autowired
	private FuneralService funeralService;

	@Autowired
	private BinsoAssignService binsoAssignService;

	@ApiOperation(value = "빈소정보", notes = "판매관리")
	@RequestMapping(value="/FUNE1011/funeral" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public MapResponse getFuneral(String customerNo) throws Exception{

		return MapResponse.of(MapUtils.getMap(MapItem.of("funeral", this.funeralService.findOneWithSum(customerNo, Part.장례식장.code()))));
	}

	@ApiOperation(value = "빈소추가/이동", notes = "빈소추가/이동")
	@RequestMapping(value="/FUNE1011/binsoAssign" , method= {RequestMethod.PUT, RequestMethod.POST}, produces=APPLICATION_JSON )
	public ApiResponse saveBinsoAssign(
			@RequestParam(required=false, value="customerNo") String beforeCustomerNo
			, @RequestParam(required=false, value="no") Integer beforeNo
			, @RequestBody BinsoAssign binsoAssign) throws Exception{
		this.binsoAssignService.saveBinsoAssign(beforeCustomerNo, beforeNo, binsoAssign);
		return ok();
	}

	@ApiOperation(value = "빈소정보", notes = "판매관리")
	@RequestMapping(value="/FUNE1011/binsoAssign/{customerNo}" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse getBinsoAssign(@PathVariable("customerNo") String customerNo) throws Exception{

		return ListResponse.of(this.binsoAssignService.findByCustomerNo(customerNo));
	}

	@ApiOperation(value = "빈소정보", notes = "판매관리")
	@RequestMapping(value="/FUNE1011/binsoAssign/{customerNo}/{no}" , method= RequestMethod.DELETE, produces=APPLICATION_JSON )
	public ApiResponse deleteBinsoAssign(
			@PathVariable("customerNo") String customerNo
			, @PathVariable("no") Integer no
			) throws Exception{
		this.binsoAssignService.deleteBinsoAssign(BinsoAssignId.of(customerNo, no));
		return ok();
	}
}
