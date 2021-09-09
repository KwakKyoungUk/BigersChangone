package net.bigers.funeralsystem.dail0000.dail1000;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.axisj.axboot.core.api.response.ApiResponse;

import net.bigers.funeralsystem.dail0000.domain.daydoc.Daydoc;
import net.bigers.funeralsystem.dail0000.domain.daydoc.DaydocId;
import net.bigers.funeralsystem.dail0000.domain.daydoc.DaydocService;
import net.bigers.funeralsystem.dail0000.domain.daylog.Daylog;
import net.bigers.funeralsystem.dail0000.domain.daylog.DaylogService;
import net.bigers.funeralsystem.dail0000.domain.daysum.DaysumService;
import net.bigers.funeralsystem.dail0000.domain.daywork.Daywork;
import net.bigers.funeralsystem.dail0000.domain.daywork.DayworkService;
import net.bigers.funeralsystem.dail0000.domain.employee.Employee;
import net.bigers.funeralsystem.dail0000.domain.employee.EmployeeService;
import net.bigers.funeralsystem.dail0000.vto.DaydocVTO;
import net.bigers.funeralsystem.dail0000.vto.DaylogVTO;
import net.bigers.funeralsystem.dail0000.vto.DayworkVTO;
import net.bigers.funeralsystem.dail0000.vto.EmployeeVTO;
import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.lib.util.MapUtils.MapItem;

/**
 *
*
* 업무분류   : 일업무관리
* 기능분류   : 운영일지등록
* 프로그램명 : 운영일지관리
* 설      명 : 운영일지 등록
* ------------------------------------------
*
* 이력사항 2016. 7. 13. SH 최초작성 <BR/>
 */
@Controller
public class DAIL1010Controller extends BaseController {

	@Autowired
	private EmployeeService employeeService;

	@Autowired
	private DayworkService dayworkService;

	@Autowired
	private DaylogService daylogService;

	@Autowired
	private DaydocService daydocService;

	@Autowired
	private DaysumService daysumService;

	@RequestMapping(value="/DAIL1010/employee/{date}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public ListResponse getEmployee(
			@PathVariable("date") @DateTimeFormat(pattern="yyyyMMdd") Date date
			){

		List<Employee> list = employeeService.findNonWorker(date);

		return ListResponse.of(EmployeeVTO.of(list));
	}

	@RequestMapping(value="/DAIL1010/daywork/{date}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public ListResponse getDaywork(
			@PathVariable("date") @DateTimeFormat(pattern="yyyyMMdd") Date date
			){

		List<Daywork> list = dayworkService.findDaywork(date);

		return ListResponse.of(DayworkVTO.of(list));
	}

	@RequestMapping(value="/DAIL1010/daylog/{date}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public MapResponse getDaylog(
			@PathVariable("date") @DateTimeFormat(pattern="yyyyMMdd") Date date
			){

		Daylog daylog = daylogService.findOne(date);

		return MapResponse.of(MapUtils.getMap(MapItem.of("DaylogVTO", DaylogVTO.of(daylog))));
	}

	@RequestMapping(value="/DAIL1010/daylog", method=RequestMethod.POST, produces=APPLICATION_JSON)
	public ApiResponse postDaylog(
			@RequestBody DaylogVTO daylogVTO
			){

		log.debug(daylogVTO.toString());

		daylogService.saveDaylog(daylogVTO);

		return ok();
	}

	@RequestMapping(value="/DAIL1010/daylog/{date}", method=RequestMethod.DELETE, produces=APPLICATION_JSON)
	public ApiResponse deleteDaylog(
			@PathVariable("date") @DateTimeFormat(pattern="yyyyMMdd") Date date
			){

		daylogService.deleteDaylog(date);

		return ok();
	}

	@RequestMapping(value="/DAIL1010/daydoc/{date}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public ListResponse getDaydoc(
			@PathVariable("date") @DateTimeFormat(pattern="yyyyMMdd") Date date
			){

		List<Daydoc> daydocList = daydocService.findByWorkDate(date);

		return ListResponse.of(DaydocVTO.of(daydocList));
	}

	@RequestMapping(value="/DAIL1010/daydoc", method=RequestMethod.DELETE, produces=APPLICATION_JSON)
	public ApiResponse deleteDaydoc(
			@RequestBody List<DaydocVTO> daydocVTOList
			){

		daydocVTOList.stream().map(daydocVTO->{
			return DaydocId.of(daydocVTO.getWorkDate(), daydocVTO.getSeq());
		}).forEach(daydocService::deleteDaydoc);

		return ok();
	}

	@RequestMapping(value="/DAIL1010/daysum/{workDate}", method=RequestMethod.POST, produces=APPLICATION_JSON)
	public ApiResponse postDaydoc(
			@PathVariable("workDate") @DateTimeFormat(pattern="yyyyMMdd") Date workDate
			){

//		daysumService.processTotal(workDate);

		return ok();
	}

	@RequestMapping(value="/DAIL1010/daysum/{from}/{to}", method=RequestMethod.POST, produces=APPLICATION_JSON)
	public ApiResponse postDaydoc(
			@PathVariable("from") @DateTimeFormat(pattern="yyyyMMdd") Date from
			, @PathVariable("to") @DateTimeFormat(pattern="yyyyMMdd") Date to
			){

//		daysumService.processTotal(from, to);

		return ok();
	}

}
