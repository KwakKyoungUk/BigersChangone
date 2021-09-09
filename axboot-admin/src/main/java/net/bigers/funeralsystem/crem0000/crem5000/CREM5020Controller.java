package net.bigers.funeralsystem.crem0000.crem5000;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.axisj.axboot.core.util.DateUtils;

import net.bigers.funeralsystem.crem0000.DisplayConstants;
import net.bigers.funeralsystem.crem0000.domain.hwaBrazier.HwaBrazier;
import net.bigers.funeralsystem.crem0000.domain.hwaBrazier.HwaBrazierService;
import net.bigers.funeralsystem.crem0000.domain.machine.Machine;
import net.bigers.funeralsystem.crem0000.domain.machine.MachineService;
import net.bigers.funeralsystem.crem0000.domain.msgset.MsgsetService;
import net.bigers.funeralsystem.crem0000.vto.HwaBrazierVTO;
import net.bigers.funeralsystem.crem0000.vto.MsgsetVTO;
import net.bigers.websocket.SessionManager;

/**
 *
 * @author SH
 * @file_name BORD1020Controller.java
 *
 * 업무분류 : 유저대기실 표출
 * 기능분류 : 현황판
 * 프로그램명 : BORD1020Controller
 * 설      명 : 유족대기실에 해당 고인의 화장 진행 상태를 표출하기 위한 컨트롤러 클래스
 * -----------------------------------------------------------
 *
 * 이력사항
 *     2016. 5. 2. SH 최초작성
 */
@Controller
@Transactional
@RequestMapping("/display/public")
public class CREM5020Controller extends BaseController{

	@Autowired
	private MsgsetService msgsetService;

	@Autowired
	private HwaBrazierService hwaBrazierService;

	@Autowired
	private MachineService machineService;

	@Autowired
	@Qualifier("textSessionManager")
	private SessionManager sessionManager;

//	@Scheduled(fixedDelay=DisplayConfigConstants.WEBSOCKET_SCHEDULE_FIXED_DELAY)
	public void bord1020(){

		if(sessionManager.isEmpty()){
			log.trace("접속한 웹소켓 클라이언트가 없습니다.");
			return;
		}

		Map<String, Object> data = new HashMap<>();

		data.put("currentTime", DateUtils.formatToDateString("yyyy-MM-dd (E) HH:mm"));
		data.put("msgset", MsgsetVTO.of(msgsetService.findFirstByTtsTargetOrderByOrdernoAsc(DisplayConstants.MACHINE_KIND_WAIT_ROOM)));

		List<Machine> machines = machineService.findByMclass(DisplayConstants.MACHINE_KIND_WAIT_ROOM);

		machines.forEach(machine->{
			if(sessionManager.containsByIp(machine.getIpaddress())){
				HwaBrazier waitRoomInfo = hwaBrazierService.findWaitRoomInfoByWaitRoom(machine.getMachineCd());
				if(waitRoomInfo != null){
					data.put("waitRoomInfo", HwaBrazierVTO.of(waitRoomInfo));
				}else{
					data.remove("waitRoomInfo");
				}
				sessionManager.sendTextMessageByIp(machine.getIpaddress(), "display", data);
			}
		});


	}

	/**
	 *
	 *
	 * 메소드 명칭 : findWaitRoom
	 * 메소드 설명 : 대기실 정보
	 * ----------------------------------------------------------
	 *
	 * @param waitRoom
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 5. 2. SH 최초작성
	 */
	@RequestMapping(value="/BORD1020/findWaitRoom/{waitRoom}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public MapResponse findWaitRoom(@PathVariable("waitRoom") String waitRoom) throws Exception{

		Map<String, Object> data = new HashMap<>();

		data.put("currentTime", DateUtils.formatToDateString("yyyy-MM-dd (E) HH:mm"));
		data.put("msgset", MsgsetVTO.of(msgsetService.findFirstByTtsTargetOrderByOrdernoAsc(DisplayConstants.MACHINE_KIND_WAIT_ROOM)));

		HwaBrazier waitRoomInfo = hwaBrazierService.findWaitRoomInfoByWaitRoom(waitRoom);

		data.put("waitRoomInfo", HwaBrazierVTO.of(waitRoomInfo));

		return MapResponse.of(data);
	}

}
