package net.bigers.funeralsystem.fune0000.fune2000;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;

import net.bigers.funeralsystem.fune0000.domain.funeral.FuneralService;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.user_mng_part.UserMngPartService;
import net.bigers.funeralsystem.fune0000.vto.FuneralVTO;

@Controller
public class FUNE2050Controller extends BaseController{

	@Inject
	private BasicCodeService basicCodeService;

	@Inject
	private FuneralService funeralService;

	@Inject
	private UserMngPartService userMngPartService;

	@RequestMapping(value="/FUNE2050/search-kind-options", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getSearchKindOptions(){
		List<BasicCode> list = basicCodeService.findByBasicCd(FuneralService.BASIC_CD_SEARCH_KIND);
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE2050/dead", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getDeadPeople(
			@RequestParam(value="searchKind") String searchKind,
			@RequestParam(value="deadName", required=false, defaultValue="") String deadName,
			@DateTimeFormat(pattern="yyyy-MM-dd") Date from,
			@DateTimeFormat(pattern="yyyy-MM-dd") Date to
			){
		List<FuneralVTO> list = funeralService.getOutedFuneral(searchKind, deadName, from, to);
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE2050/part", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getPart(){
		List<Part> list = this.userMngPartService.getByCurrentUser();
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE2050/assignedDead", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getAssignedDead(){
		List<FuneralVTO> list = funeralService.getAssignedDead();
		return CommonListResponseParams.ListResponse.of(list);
	}
}
