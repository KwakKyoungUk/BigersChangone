package net.bigers.funeralsystem.fune0000.fune5000;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.common.vto.OptionVTO;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.fune0000.domain.total_part.TotalPartService;

@Controller
public class FUNE5011Controller extends BaseController {

	@Autowired
	private TotalPartService totalPartService;

	@Autowired
	private PartService partService;

	@ApiOperation(value = "마감내역", notes = "마감내역")
	@RequestMapping(value="/FUNE5011/totalPart" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse getTotalPart(String customerNo) throws Exception{

		return ListResponse.of(this.totalPartService.findByCustomerNo(customerNo));
	}

	@ApiOperation(value = "파트일괄마감", notes = "파트일괄마감")
	@RequestMapping(value="/FUNE5011/openAllPart/{customerNo}" , method= RequestMethod.PUT, produces=APPLICATION_JSON )
	public ApiResponse openAllPart(
			@PathVariable("customerNo") String customerNo
			) throws Exception{

		this.totalPartService.openAllPart(customerNo);

		return ok();
	}

	@ApiOperation(value = "파트마감", notes = "파트마감")
	@RequestMapping(value="/FUNE5011/closePart/{customerNo}/{partCode}" , method= RequestMethod.PUT, produces=APPLICATION_JSON )
	public ApiResponse closePart(
			@PathVariable("customerNo") String customerNo
			, @PathVariable("partCode") String partCode
			) throws Exception{

		this.totalPartService.closePart(customerNo, partCode);

		return ok();
	}

	@ApiOperation(value = "파트마감해제", notes = "파트마감해제")
	@RequestMapping(value="/FUNE5011/openPart/{customerNo}/{partCode}" , method= RequestMethod.PUT, produces=APPLICATION_JSON )
	public ApiResponse openPart(
			@PathVariable("customerNo") String customerNo
			, @PathVariable("partCode") String partCode
			) throws Exception{

		this.totalPartService.openPart(customerNo, partCode);

		return ok();
	}

	@ApiOperation(value = "파트마감", notes = "파트마감")
	@RequestMapping(value="/FUNE5011/part/option" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public List<OptionVTO> getPartOption() throws Exception{

		return this.partService.findAll().stream().map(part->OptionVTO.of(part.getPartCode(), part.getPartName())).collect(Collectors.toList());
	}
}
