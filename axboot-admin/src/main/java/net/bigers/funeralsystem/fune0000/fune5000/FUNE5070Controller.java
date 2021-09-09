package net.bigers.funeralsystem.fune0000.fune5000;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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

import net.bigers.funeralsystem.common.vto.AjaxOptionVTO;
import net.bigers.funeralsystem.common.vto.OptionVTO;
import net.bigers.funeralsystem.fune0000.domain.funeral.FuneralService;
import net.bigers.funeralsystem.fune0000.domain.part.Part;
import net.bigers.funeralsystem.fune0000.domain.part.PartService;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt_bd.SaleStmtBd;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt_bd.SaleStmtBdService;
import net.bigers.funeralsystem.fune0000.domain.user_mng_part.UserMngPartService;
import net.bigers.funeralsystem.fune0000.vto.FuneralVTO;
import net.bigers.funeralsystem.lib.util.MapUtils;

@Controller
public class FUNE5070Controller extends BaseController{

	@Inject
	private BasicCodeService basicCodeService;

	@Inject
	private FuneralService funeralService;

	@Inject
	private PartService partService;

	@Inject
	private SaleStmtBdService saleStmtBdService;

	@Inject
	private UserMngPartService userMngPartService;

	@RequestMapping(value="/FUNE5070/search-kind-options", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getSearchKindOptions(){
		List<BasicCode> list = basicCodeService.findByBasicCd(FuneralService.BASIC_CD_SEARCH_KIND);
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE5070/dead", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getDeadPeople(
			@RequestParam(value="searchKind") String searchKind,
			@RequestParam(value="deadName", required=false, defaultValue="") String deadName,
			@RequestParam(value="balinDate", required=false, defaultValue="") String balinDate){
		List<FuneralVTO> list = funeralService.getOutedFuneral(searchKind, deadName, balinDate);
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE5070/funeral", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public MapResponse getDeadPeople(String customerNo){

		return MapResponse.of(MapUtils.getMap("funeral", this.funeralService.findOne(customerNo)));
	}

	@RequestMapping(value="/FUNE5070/part", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public AjaxOptionVTO getPart(){
		List<Part> list = this.userMngPartService.getByCurrentUser();
		return AjaxOptionVTO.of("ok", list.stream().map(o->OptionVTO.of(o.getPartCode(), o.getPartName())).collect(Collectors.toList()), "");
	}

	@RequestMapping(value="/FUNE5070/sale", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getSale(@RequestParam Map<String, String> requestBody){
		String customerNo 	= requestBody.get("customerNo");
		String partCode 	= requestBody.get("partCode");
		List<SaleStmtBd> list = saleStmtBdService.findByCustomerNoAndPartCode(customerNo, partCode);
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE5070/assignedDead", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getAssignedDead(){
		List<FuneralVTO> list = funeralService.getAssignedDead();
		return CommonListResponseParams.ListResponse.of(list);
	}
}
