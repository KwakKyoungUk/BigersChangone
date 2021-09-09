package net.bigers.funeralsystem.fune0000.fune1000;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;

import net.bigers.funeralsystem.fune0000.domain.funeral.Funeral;
import net.bigers.funeralsystem.fune0000.domain.funeral.FuneralService;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt.SaleStmtService;
import net.bigers.funeralsystem.fune0000.domain.user_mng_part.UserMngPartService;
import net.bigers.funeralsystem.fune0000.vto.FuneralVTO;
import net.bigers.funeralsystem.lib.util.MapUtils;

@Controller
public class FUNE1060Controller extends BaseController{

	@Inject
	private BasicCodeService basicCodeService;

	@Inject
	private FuneralService funeralService;

	@Inject
	private UserMngPartService userMngPartService;

	@Inject
	private SaleStmtService saleStmtService;

	@RequestMapping(value="/FUNE1060/search-kind-options", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getSearchKindOptions(){
		List<BasicCode> list = basicCodeService.findByBasicCd(FuneralService.BASIC_CD_SEARCH_KIND);
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE1060/dead", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getDeadPeople(
			@RequestParam(value="searchKind") String searchKind,
			@RequestParam(value="deadName", required=false, defaultValue="") String deadName,
			@RequestParam(value="balinDate", required=false, defaultValue="") String balinDate){
		List<FuneralVTO> list = funeralService.getOutedFuneral(searchKind, deadName, balinDate);
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE1060/part", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getPart(){
		List<Part> list = this.userMngPartService.getByCurrentUser();
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE1060/assignedDead", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getAssignedDead(){
		List<FuneralVTO> list = funeralService.getAssignedDead();
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE1060/funeral", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public MapResponse getSaleStmt(String customerNo, String partCode){
		Funeral funeral = this.funeralService.findOne(customerNo);
		funeral.getSaleStmt().removeIf(ss->!ss.getPartCode().equals(partCode));
		return MapResponse.of(MapUtils.getMap("funeral", funeral));
	}
}
