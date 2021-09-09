package net.bigers.funeralsystem.crem0000.crem5000;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;

import net.bigers.funeralsystem.crem0000.domain.hwaBrazier.HwaBrazierService;
import net.bigers.funeralsystem.crem0000.vto.HwaBrazierVTO;

/**
 *
 * 업무분류   : 고별실 표출
 * 기능분류   : 고별실 표출
 * 프로그램명 : BORD1040
 * 설      명 : 고별실 표출 컨트롤러 클래스
 * ------------------------------------------
 *
 * 이력사항 2015. 4. 20. 이승호 최초작성 <BR/>
 */
@Controller
@RequestMapping("/display/public")
public class CREM5040Controller extends BaseController{

	@Autowired
	private HwaBrazierService hwaBrazierService;

	/**
	 *
	 *
	 * 메소드 명칭 : findByeRoom
	 * 메소드 설명 : 고별실 로직은 업무랑 관련 있음.
	 * 					최초 접수가 되어 있고 운구가 시작되면 담당자는 화장상태를 운구중으로 변환. -> udttime이 변환 시간으로 수정됨.
	 * 					오늘 날짜, 고별실 코드, 화장상태 운구중, udttime이 max 또는 desc로 정렬한 첫번째 레코드를 가지고 오면 고별실 사용 고인 정보를 가지고 온다.
	 * ----------------------------------------------------------
	 *
	 * @param byeRoom
	 * @return
	 * @throws Exception
	 *
	 * 이력사항
	 *     2016. 5. 2. SH 최초작성
	 */
	@RequestMapping(value="/BORD1040/findByeRoom/{byeRoom}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public MapResponse findByeRoom(@PathVariable("byeRoom") String byeRoom) throws Exception{

		Map<String, Object> map = new HashMap<>();

		map.put("byeRoomInfo", HwaBrazierVTO.of(hwaBrazierService.findByeRoomInfoByByeRoom(byeRoom)));

		return MapResponse.of(map);
	}


}
