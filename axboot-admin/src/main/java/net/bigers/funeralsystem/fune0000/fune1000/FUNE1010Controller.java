package net.bigers.funeralsystem.fune0000.fune1000;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.fune0000.domain.binso.BinsoService;
import net.bigers.funeralsystem.fune0000.domain.total_part.TotalPartService;

@Controller
public class FUNE1010Controller extends BaseController {

	@Autowired
	private BinsoService binsoService;

	@Autowired
	private TotalPartService totalPartService;

	@ApiOperation(value = "빈소정보", notes = "판매관리")
	@RequestMapping(value="/FUNE1010/binso/part" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ListResponse binsoPart() throws Exception{

		return ListResponse.of(this.binsoService.getSaleBinsoInfo2());
	}

	@ApiOperation(value = "파트마감", notes = "파트마감")
	@RequestMapping(value="/FUNE1010/binso/part/close/{customerNo}/{part}" , method= RequestMethod.PUT, produces=APPLICATION_JSON )
	public ApiResponse closePart(
			@PathVariable("customerNo") String customerNo
			, @PathVariable("part") String part
			) throws Exception{

		this.totalPartService.closePart(customerNo, part);

		return ok();
	}

	@ApiOperation(value = "파트마감", notes = "파트마감")
	@RequestMapping(value="/FUNE1010/binso/part/close/{customerNo}/all" , method= RequestMethod.PUT, produces=APPLICATION_JSON )
	public ApiResponse closePart(
			@PathVariable("customerNo") String customerNo
			) throws Exception{

		this.totalPartService.closeAllPart(customerNo);

		return ok();
	}

	@ApiOperation(value = "마감여부", notes = "마감여부")
	@RequestMapping(value="/FUNE1010/binso/part/isclose/{customerNo}/{part}" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public ApiResponse isClose(
			@PathVariable("customerNo") String customerNo
			, @PathVariable("part") String part
			) throws Exception{

		if(this.totalPartService.isClose(customerNo, part)) {
			throw new Exception("마감된 파트입니다.  판매전표를 등록하실 수 없습니다.");
		}

		return ok();
	}
}
