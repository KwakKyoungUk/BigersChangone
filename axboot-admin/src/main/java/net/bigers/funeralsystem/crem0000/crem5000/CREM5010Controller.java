package net.bigers.funeralsystem.crem0000.crem5000;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.util.DateUtils;

import net.bigers.funeralsystem.crem0000.DisplayConstants;
import net.bigers.funeralsystem.crem0000.domain.hwaBrazier.HwaBrazier;
import net.bigers.funeralsystem.crem0000.domain.hwaBrazier.HwaBrazierService;
import net.bigers.funeralsystem.crem0000.domain.machine.Machine;
import net.bigers.funeralsystem.crem0000.domain.machine.MachineService;
import net.bigers.funeralsystem.crem0000.domain.msgset.Msgset;
import net.bigers.funeralsystem.crem0000.domain.msgset.MsgsetService;
import net.bigers.funeralsystem.crem0000.vto.HwaBrazierVTO;
import net.bigers.funeralsystem.crem0000.vto.MsgsetVTO;
import net.bigers.websocket.SessionManager;

/**
 *
 * 업무분류   : 전체 현황판
 * 기능분류   : 현황판 출력을 위한 컨트롤러
 * 프로그램명 : BORD1010
 * 설      명 : 전체 현황판을 출력하기 위한 뷰 연결 및 데이를 얻기 위한 서비스 연결
 * 				강릉 eXria로 제작된 프로그램을 axboot로 변경
 * ------------------------------------------
 *
 * 이력사항 2016. 2. 29. 이승호 최초작성 <BR/>
 */
@Controller
@SessionAttributes("displayPagable")
public class CREM5010Controller extends BaseController{

	@Autowired
	private HwaBrazierService hwaBrazierService;

	@Autowired
	private MsgsetService msgsetService;

	@Autowired
	private MachineService machineService;

	@Autowired
	@Qualifier("textSessionManager")
	private SessionManager sessionManager;

	private Pageable pageRequest = new PageRequest(0, 5);

	/**
	 *
	 *
	 * 메소드 명칭 : bord1010
	 * 메소드 설명 : WebSocket 으로 접속한 현황판 기기로 데이터 전송
	 * ----------------------------------------------------------
	 *
	 *
	 * 이력사항
	 *     2016. 5. 18. SH 최초작성
	 */
//	@Scheduled(fixedDelay=DisplayConfigConstants.WEBSOCKET_SCHEDULE_FIXED_DELAY)
	public void bord1010(){

		if(sessionManager.isEmpty()){
			log.trace("접속한 웹소켓 클라이언트가 없습니다.");
			return;
		}

		List<Machine> machines = machineService.findByMclass(DisplayConstants.MACHINE_KIND_BURN_BOARD);

		Page<HwaBrazier> hwaBrazierPages = hwaBrazierService.findDisplayHwaBrazier(pageRequest);

		if(hwaBrazierPages.hasNext()){
			this.pageRequest = this.pageRequest.next();
		}else{
			this.pageRequest = this.pageRequest.first();
		}

		Msgset msgset = msgsetService.findFirstByTtsTargetOrderByOrdernoAsc(DisplayConstants.MACHINE_KIND_BURN_BOARD);

		Map<String, Object> result = new HashMap<>();

		result.put("hwaBrazierVTO", HwaBrazierVTO.of(hwaBrazierPages.getContent()));
		result.put("msgsetVTO", MsgsetVTO.of(msgset));
		result.put("currentDate", DateUtils.formatToDateString("yyyy.MM.dd (E) a hh:mm"));

		machines.forEach(machine->{
			sessionManager.sendTextMessageByIp(machine.getIpaddress(), "display", result);
		});
	}


	/**
	 *
	 *
	 * 메소드 명칭 : displayPagable
	 * 메소드 설명 : 페이지 전환 시 보여줄 페이지
	 * ----------------------------------------------------------
	 *
	 * @param displayPagable
	 * @return
	 *
	 * 이력사항
	 *     2016. 4. 27. SH 최초작성
	 */
	@ModelAttribute("displayPagable")
	public Pageable displayPagable(Pageable displayPagable){
		if(displayPagable == null || displayPagable.getPageSize() != 5){
			return new PageRequest(0, 5);
		}
		return displayPagable;
	}

	/**
	 *
	 *
	 * 메소드 명칭 : findHwaBrazier
	 * 메소드 설명 : 현재 화장 데이터
	 * ----------------------------------------------------------
	 *
	 * @param model
	 * @param displayPagable
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 4. 27. SH 최초작성
	 */
	@RequestMapping(value="/findHwaBrazier", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse findHwaBrazier(
				Model model
				, @ModelAttribute("displayPagable") Pageable displayPagable
			) throws Exception{

		Page<HwaBrazier> hwaBrazierPages = hwaBrazierService.findDisplayHwaBrazier(displayPagable);

		if(hwaBrazierPages.hasNext()){
			model.addAttribute("displayPagable", displayPagable.next());
		}else{
			model.addAttribute("displayPagable", displayPagable.first());
		}

		Msgset msgset = msgsetService.findFirstByTtsTargetOrderByOrdernoAsc(DisplayConstants.MACHINE_KIND_BURN_BOARD);

		Map<String, Object> result = new HashMap<>();

		result.put("hwaBrazierVTO", HwaBrazierVTO.of(hwaBrazierPages.getContent()));
		result.put("msgsetVTO", MsgsetVTO.of(msgset));
		result.put("currentDate", DateUtils.formatToDateString("yyyy.MM.dd (E) a hh:mm"));

		return CommonListResponseParams.MapResponse.of(result);
	}


}
