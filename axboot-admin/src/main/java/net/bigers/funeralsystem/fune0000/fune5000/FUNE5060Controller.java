package net.bigers.funeralsystem.fune0000.fune5000;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;

import net.bigers.funeralsystem.fune0000.domain.funeral.FuneralService;
import net.bigers.funeralsystem.fune0000.vto.FuneralVTO;

@Controller
public class FUNE5060Controller extends BaseController{

	@Inject
	private BasicCodeService basicCodeService;

	@Inject
	private FuneralService funeralService;

	@RequestMapping(value="/FUNE5060/search-kind-options", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getSearchKindOptions(){
		List<BasicCode> list = basicCodeService.findByBasicCd(FuneralService.BASIC_CD_SEARCH_KIND);
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE5060/dead", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getDeadPeople(
			@RequestParam(value="searchKind") String searchKind,
			@RequestParam(value="deadName", required=false, defaultValue="") String deadName,
			@RequestParam(value="balinDate", required=false, defaultValue="") String balinDate){
		List<FuneralVTO> list = funeralService.getOutedFuneral(searchKind, deadName, balinDate);
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE5060/assignedDead", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getAssignedDead(){
		List<FuneralVTO> list = funeralService.getAssignedDead();
		return CommonListResponseParams.ListResponse.of(list);
	}

}
