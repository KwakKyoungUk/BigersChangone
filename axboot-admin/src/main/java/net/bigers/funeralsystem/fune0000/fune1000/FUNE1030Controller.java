package net.bigers.funeralsystem.fune0000.fune1000;

import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.common.domain.history.HistoryService;
import net.bigers.funeralsystem.common.vto.AjaxOptionVTO;
import net.bigers.funeralsystem.common.vto.OptionVTO;
import net.bigers.funeralsystem.dail0000.domain.employee.EmployeeService;
import net.bigers.funeralsystem.fune0000.domain.binso.Binso;
import net.bigers.funeralsystem.fune0000.domain.binso.BinsoService;
import net.bigers.funeralsystem.fune0000.domain.binso_assign.BinsoAssignService;
import net.bigers.funeralsystem.fune0000.domain.dc_rate.DcRateService;
import net.bigers.funeralsystem.fune0000.domain.family_clan.FamilyClanService;
import net.bigers.funeralsystem.fune0000.domain.funeral.Funeral;
import net.bigers.funeralsystem.fune0000.domain.funeral.FuneralService;
import net.bigers.funeralsystem.fune0000.domain.funeral.Part;
import net.bigers.funeralsystem.fune0000.domain.total_part.TotalPartService;
import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.lib.util.MapUtils.MapItem;

@Controller
public class FUNE1030Controller extends BaseController {

	@Autowired
	private FamilyClanService familyClanService;

	@Autowired
	private BinsoService binsoService;

	@Autowired
	private FuneralService funeralService;

	@Autowired
	private DcRateService dcRateService;

	@Autowired
	private BinsoAssignService binsoAssignService;

	@Autowired
	private EmployeeService employeeService;

	@Autowired
	private TotalPartService totalPartService;

	@ApiOperation(value = "고인본관", notes = "고인본관 inputSelector")
	@RequestMapping(value="/FUNE1030/familyClan/code" , method= RequestMethod.GET, produces=APPLICATION_JSON )
	public List<String> getFamilyClanCode(String keyword) throws Exception{

		return this.familyClanService.getFamilyClanNames(keyword);
	}

	@ApiOperation(value = "배정가능 빈소", notes = "배정가능 빈소")
	@RequestMapping(value="/FUNE1030/binso/assignable/code/option/ajax" , method= {RequestMethod.GET, RequestMethod.POST}, produces=APPLICATION_JSON )
	public AjaxOptionVTO getAjaxAssignableBinsoCode() throws Exception{

		return AjaxOptionVTO.of("ok", this.binsoService.getAssignableBinsoCode(), "");
	}

	@ApiOperation(value = "배정된 빈소", notes = "배정가능 빈소")
	@RequestMapping(value="/FUNE1030/binso/assigned/code/option/ajax" , method= {RequestMethod.GET, RequestMethod.POST}, produces=APPLICATION_JSON )
	public AjaxOptionVTO getAjaxAssignedBinsoCode(String customerNo) throws Exception{

//		Binso binso = this.binsoAssignService.getNewBinso(customerNo);
		Binso binso = this.funeralService.findOne(customerNo).getBinso();
		return AjaxOptionVTO.of("ok", Arrays.asList(OptionVTO.of(binso.getBinsoCode(), binso.getBinsoName())), "");
	}

	@ApiOperation(value = "배정가능 빈소", notes = "배정가능 빈소")
	@RequestMapping(value="/FUNE1030/binso/assignable/code/option" , method= {RequestMethod.GET, RequestMethod.POST}, produces=APPLICATION_JSON )
	public List<OptionVTO> getAssignableBinsoCode() throws Exception{

		return this.binsoService.getAssignableBinsoCode();
	}

	@ApiOperation(value = "감면율", notes = "감면율")
	@RequestMapping(value="/FUNE1030/dcRate/code/option/ajax" , method= {RequestMethod.GET, RequestMethod.POST}, produces=APPLICATION_JSON )
	public AjaxOptionVTO getAjaxDcCode(String jobGubun) throws Exception{

		return AjaxOptionVTO.of("ok", this.dcRateService.findByJobGubun(jobGubun).stream().map(dcRate->OptionVTO.of(dcRate.getDcCode(), dcRate.getDcName())).collect(Collectors.toList()), "");
	}

	@ApiOperation(value = "감면율", notes = "감면율")
	@RequestMapping(value="/FUNE1030/dcRate/code/option" , method= {RequestMethod.GET, RequestMethod.POST}, produces=APPLICATION_JSON )
	public List<OptionVTO> getDcCodeOption(String jobGubun) throws Exception{

		return this.dcRateService.findByJobGubun(jobGubun).stream().map(dcRate->OptionVTO.of(dcRate.getDcCode(), dcRate.getDcName())).collect(Collectors.toList());
	}

	@RequestMapping(value="/FUNE1030/funeral" , method= {RequestMethod.PUT, RequestMethod.POST}, produces=APPLICATION_JSON )
	public MapResponse saveFuneral(@RequestBody Funeral funeral) throws Exception{
		funeral = this.funeralService.saveFuneral(funeral);
		try {
			HistoryService.addHistory("저장] 고객등록("+funeral.getCustomerNo()+") 신청자 - "+funeral.getApplicant().getApplName());
		}catch (Exception e) {
		}

		return MapResponse.of(MapUtils.getMap(MapItem.of("funeral", funeral)));
	}

	@RequestMapping(value="/FUNE1030/funeral" , method= {RequestMethod.GET}, produces=APPLICATION_JSON )
	public MapResponse getFuneral(String customerNo) throws Exception{
		Funeral funeral = this.funeralService.findOne(customerNo);
		Map<String, Object> res = MapUtils.getMap(MapItem.of("funeral", funeral));
		res.put("isClose", this.totalPartService.isClose(customerNo, Part.장례식장.code()));
		try {
			HistoryService.addHistory("조회] 고객조회("+customerNo+") 신청자 - "+funeral.getApplicant().getApplName());
		}catch (Exception e) {
		}

		return MapResponse.of(res);
	}

	@ApiOperation(value = "고객조회", notes = "관내외사유")
	@RequestMapping(value="/FUNE1030/dcCode" , method= {RequestMethod.GET}, produces=APPLICATION_JSON )
	public MapResponse getDcCode(String addrPart, String addr1, String dcGubun, @DateTimeFormat(pattern="yyyy-MM-dd") Date transferDate) throws Exception{
		return MapResponse.of(MapUtils.getMap("dcCode", this.dcRateService.getDcCode(addrPart, addr1, dcGubun, transferDate)));
	}

	@ApiOperation(value = "근무자", notes = "근무자")
	@RequestMapping(value="/FUNE1030/employee/options" , method= {RequestMethod.GET}, produces=APPLICATION_JSON )
	public List<OptionVTO> getEmployee() throws Exception{
		return this.employeeService.findAll().stream().map(e->OptionVTO.of(e.getEmpCode(), e.getEmpName())).collect(Collectors.toList());
	}
}
