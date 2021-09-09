package net.bigers.funeralsystem.stan0000.stan1000;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.admin.parameter.PageableResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;
import com.axisj.axboot.core.dto.PageableTO;
import com.axisj.axboot.core.util.DozerBeanMapperUtils;
import com.axisj.axboot.core.vto.BasicCodeVTO;

import net.bigers.funeralsystem.crem0000.DisplayConstants;
import net.bigers.funeralsystem.crem0000.domain.machine.Machine;
import net.bigers.funeralsystem.crem0000.domain.machine.MachineService;
import net.bigers.funeralsystem.crem0000.vto.HwaBookingVTO;
import net.bigers.funeralsystem.crem0000.vto.MachineVTO;
import net.bigers.funeralsystem.dail0000.domain.employee.Employee;
import net.bigers.funeralsystem.dail0000.domain.employee.EmployeeService;
import net.bigers.funeralsystem.dail0000.vto.EmployeeVTO;

/**
 *
 * 업무분류   : 근무자 등록
 * 기능분류   : 근무자등록
 * 프로그램명 : 근무자 관리 프로그램
 * 설      명 : 
 * ------------------------------------------
 *
 */
@Controller
public class STAN1090Controller extends BaseController{

	@Autowired
	private EmployeeService employeeService;

	@Autowired
	private BasicCodeService basicCodeService;

	/**
	 * 
	 * 메소드명칭 : findEmployee
	 * 메소드설명 : 근무자 조회	
	 * ----------------------------------------
	 * 이력사항 2016. 8. 20. kdh 최초작성
	 *
	 * @param empName
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/STAN1090/findEmployee", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public PageableResponseParams.PageResponse findEmployee(@RequestParam(value = "empName") String empName,Pageable pageable) throws Exception{

		Page<Employee> employees = employeeService.findByEmpNameEndingWithOrderByOrderseqAsc(empName,pageable);

		return PageableResponseParams.PageResponse.of(EmployeeVTO.of(employees.getContent()), PageableTO.of(employees));
	}

	/**
	 * 
	 * 메소드명칭 : saveEmployee
	 * 메소드설명 : 근무자 저장	
	 * ----------------------------------------
	 * 이력사항 2016. 8. 20. kdh 최초작성
	 *
	 * @param EmployeeVTOs
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/STAN1090/saveEmployee", method={RequestMethod.POST,RequestMethod.PUT}, produces=APPLICATION_JSON)
	public ApiResponse saveEmployee(@RequestBody List<EmployeeVTO> EmployeeVTOs) throws Exception{
		List<Employee> employees = DozerBeanMapperUtils.mapList(EmployeeVTOs, Employee.class);
		employeeService.save(employees);
		return ok();
	}

	/**
	 * 
	 * 메소드명칭 : deleteEmployee
	 * 메소드설명 : 근무자삭제		
	 * ----------------------------------------
	 * 이력사항 2016. 8. 20. kdh 최초작성
	 *
	 * @param empCodes
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/STAN1090/deleteEmployee", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deleteEmployee(@RequestParam("empCode") List<String> empCodes) throws Exception{
		empCodes.forEach(empCode -> employeeService.delete(empCode));
		return ok();
	}

}
