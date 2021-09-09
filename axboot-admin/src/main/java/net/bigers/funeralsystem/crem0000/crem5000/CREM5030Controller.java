package net.bigers.funeralsystem.crem0000.crem5000;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;

import net.bigers.funeralsystem.crem0000.DisplayConstants;
import net.bigers.funeralsystem.crem0000.domain.hwaBrazier.HwaBrazierService;
import net.bigers.funeralsystem.crem0000.domain.machine.Machine;
import net.bigers.funeralsystem.crem0000.domain.machine.MachineService;
import net.bigers.funeralsystem.crem0000.vto.HwaBrazierVTO;
import net.bigers.websocket.SessionManager;

/**
 *
 * @author SH
 * @file_name BORD1030Controller.java
 *
 * 업무분류 : 화로 표출
 * 기능분류 : 화로 표출
 * 프로그램명 : BORD1030
 * 설      명 : 화로앞 고인명 및 상태 표출 컨트롤러 클래스
 * -----------------------------------------------------------
 *
 * 이력사항
 *     2016. 5. 2. SH 최초작성
 */
@Controller
@RequestMapping("/display/public")
public class CREM5030Controller extends BaseController{

	@Autowired
	private HwaBrazierService hwaBrazierService;

	@Autowired
	@Qualifier("textSessionManager")
	private SessionManager sessionManager;

	@Autowired
	private MachineService machineService;

	@Autowired
	private BasicCodeService basicCodeService;

//	@Scheduled(fixedDelay=DisplayConfigConstants.WEBSOCKET_SCHEDULE_FIXED_DELAY)
	public void bord1030(){

		if(sessionManager.isEmpty()){
			log.trace("접속한 웹소켓 클라이언트가 없습니다.");
			return;
		}

		Map<String, Object> data = new HashMap<>();


		List<Machine> machines = machineService.findByMclass(DisplayConstants.MACHINE_KIND_BURN_LINE);

		List<BasicCode> codes = basicCodeService.findByBasicCd(DisplayConstants.BASIC_CODE_BURN_LINE);

		codes.forEach(code->{
			machines.forEach(machine->{
				// 화로기기의 ip로 접속한 클라이언트가 존재하고 code.data1(machine code)와 Machine.machineCd 가 같을 경우
				if(sessionManager.containsByIp(machine.getIpaddress()) && machine.getMachineCd().equals(code.getData1())){
					HwaBrazierVTO burnLineInfo = HwaBrazierVTO.of(hwaBrazierService.findBurnLineInfoByBurnNo(code.getCode()));
					if(burnLineInfo != null){
						data.put("burnLineInfo", burnLineInfo);
					}else{
						data.remove("burnLineInfo");
					}
					sessionManager.sendTextMessageByIp(machine.getIpaddress(), "display", data);
				}
			});
		});

	}

	/**
	 *
	 *
	 * 메소드 명칭 : findBurnLine
	 * 메소드 설명 : 금일 특정 화로의 정보
	 * ----------------------------------------------------------
	 *
	 * @param burnNo
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 5. 2. SH 최초작성
	 */
	@RequestMapping(value="/BORD1030/findBurnLine/{burnNo}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public MapResponse findBurnLine(@PathVariable("burnNo") String burnNo) throws Exception{

		Map<String, Object> data = new HashMap<>();

		data.put("burnLineInfo", HwaBrazierVTO.of(hwaBrazierService.findBurnLineInfoByBurnNo(burnNo)));

		return MapResponse.of(data);
	}


}
