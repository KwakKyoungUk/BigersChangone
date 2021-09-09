package net.bigers.funeralsystem.stan0000.stan1000;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;
import com.axisj.axboot.core.util.DozerBeanMapperUtils;
import com.axisj.axboot.core.vto.BasicCodeVTO;

import net.bigers.funeralsystem.crem0000.DisplayConstants;
import net.bigers.funeralsystem.crem0000.domain.machine.Machine;
import net.bigers.funeralsystem.crem0000.domain.machine.MachineService;
import net.bigers.funeralsystem.crem0000.vto.MachineVTO;

/**
 *
 * 업무분류   : 설치 장비 등록
 * 기능분류   : 설치장비등록
 * 프로그램명 : 설치 장비 관리 프로그램
 * 설      명 : 설치 장비의 기본 페이지 및 아이피 관리 프로그램
 * ------------------------------------------
 *
 * 이력사항 2016. 3. 23. 이승호 최초작성 <BR/>
 */
@Controller
public class STAN1080Controller extends BaseController{

	@Autowired
	private MachineService machineService;

	@Autowired
	private BasicCodeService basicCodeService;

	/**
	 *
		 *
		 * 메소드 명칭 : findMachine
		 * 메소드 설명 : 설치장비 목록 출력
		 * ----------------------------------------
		 * 이력사항 2016. 3. 23. 이승호 최초작성
		 * 수정사항 		 *
		 * @param searchParams : 장비이름(검색조건)
		 * @return CommonListResponseParams.MapResponse
		 * @throws Exception
	 */
	@RequestMapping(value="/STAN1080/findMachine", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse findMachine(@RequestParam(value = "searchParams") String searchParams) throws Exception{

		List<Machine> machines = machineService.findByMachineNmContaining(searchParams);

		return CommonListResponseParams.ListResponse.of(MachineVTO.of(machines));
	}

	/**
	 *
		 *
		 * 메소드 명칭 : findMclass
		 * 메소드 설명 : 설치장비 종류
		 * ----------------------------------------
		 * 이력사항 2014. 10. 15. 김동호 최초작성
		 * 수정사항 		 *
		 * @param
		 * @return CommonListResponseParams.ListResponse
		 * @throws Exception
	 */
	@RequestMapping(value="/STAN1080/findMclass", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse findMclass() throws Exception{
		List<BasicCode> mclass = basicCodeService.findByBasicCd(DisplayConstants.BASIC_CODE_MACHINE_KIND);
		return CommonListResponseParams.ListResponse.of(BasicCodeVTO.of(mclass));
	}

	/**
	 *
		 *
		 * 메소드 명칭 : saveMachine
		 * 메소드 설명 : 설치장비 목록 저장
		 * ----------------------------------------
		 * 이력사항 2016. 3. 23. 이승호 최초작성
		 * @param machineVTOs 데이타
		 * @return ApiResponse ok
		 * @throws Exception
	 */
	@RequestMapping(value="/STAN1080/saveMachine", method={RequestMethod.POST,RequestMethod.PUT}, produces=APPLICATION_JSON)
	public ApiResponse saveMachine(@RequestBody List<MachineVTO> machineVTOs) throws Exception{
		List<Machine> machines = DozerBeanMapperUtils.mapList(machineVTOs, Machine.class);
		machineService.save(machines);
		return ok();
	}

	/**
	 *
	 *
	 * 메소드 명칭 : deleteMachine
	 * 메소드 설명 : 설치장비 삭제
	 * ----------------------------------------
	 * 이력사항 2016. 3. 23. 이승호 최초작성
	 * @param machineCds 삭제 데이타 키
	 * @return ApiResponse ok
	 * @throws Exception
	 */
	@RequestMapping(value="/STAN1080/deleteMachine", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deleteMachine(@RequestParam("machineCd") List<String> machineCds) throws Exception{
		machineCds.forEach(machineCd -> machineService.delete(machineCd));
		return ok();
	}

	/**
	 *
	 * 메소드 명칭 : exportExcelMachineList
	 * 메소드 설명 : 설치장비 목록을 엑셀로 export 한다.
	 * ----------------------------------------
	 * 이력사항 2014. 10. 17. 김동호 최초작성
	 *
	 * @param MACHINE_NM : 장비이름(검색조건)
	 * @return exriaView
	 * @throws Exception
	 */

//	@RequestMapping("/SYST1020/ExportExcelMachineList.ex")
//	public ModelAndView exportExcelMachineList(@RequestParam(value = "MACHINE_NM") String machineName) throws Exception{
//
//		Map<String, Object> data = syst1020Service.exportExcelMachineList(machineName);
//
//		return makeModelForExria(data);
//	}
}
