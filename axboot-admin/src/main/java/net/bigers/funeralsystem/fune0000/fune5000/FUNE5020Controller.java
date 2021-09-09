package net.bigers.funeralsystem.fune0000.fune5000;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.common.vto.OptionVTO;
import net.bigers.funeralsystem.fune0000.domain.binso.BinsoService;
import net.bigers.funeralsystem.fune0000.domain.binso_assign.BinsoAssignService;
import net.bigers.funeralsystem.fune0000.domain.funeral.Funeral;
import net.bigers.funeralsystem.fune0000.domain.funeral.FuneralService;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;

@Controller
public class FUNE5020Controller extends BaseController {

	@Autowired
	private BinsoService binsoService;

	@Autowired
	private BinsoAssignService binsoAssignService;

	@Autowired
	private PartService partService;

	@Autowired
	private FuneralService funeralService;

	@ApiOperation(value = "빈소 퇴실 취소", notes = "빈소 퇴실 처리")
	@RequestMapping(value="/FUNE5020/binso/in/{customerNo}/{binsoCode}" , method= RequestMethod.POST, produces=APPLICATION_JSON )
	public ApiResponse outBinso(
			@PathVariable("customerNo") String customerNo
			, @PathVariable("binsoCode") String binsoCode
			) throws Exception{

		this.binsoAssignService.inoutBinso(customerNo, binsoCode, 0);

		return ok();
	}

	@ApiOperation(value = "고객조회", notes = "고객조회")
	@RequestMapping(value="/FUNE5020/funeral" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public List<Funeral> getFuneral(
			String deadName
			, @DateTimeFormat(pattern="yyyy-MM-dd") Date balinDate
			) throws Exception{

		return this.funeralService.getInOutFuneral(deadName, balinDate, 1);
	}

	@ApiOperation(value = "고객조회", notes = "고객조회")
	@RequestMapping(value="/FUNE5020/part" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public List<OptionVTO> getPart() throws Exception{

		return this.partService.findByPartGroupCodeNot("7").stream().map(p->OptionVTO.of(p.getPartCode(), p.getPartName())).collect(Collectors.toList());
	}


}
