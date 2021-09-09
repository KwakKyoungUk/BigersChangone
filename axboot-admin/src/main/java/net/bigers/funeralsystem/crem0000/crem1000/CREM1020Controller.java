package net.bigers.funeralsystem.crem0000.crem1000;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.PageableResponseParams;
import com.axisj.axboot.core.dto.PageableTO;

import net.bigers.funeralsystem.crem0000.domain.hwabooking.HwaBookingService;
import net.bigers.funeralsystem.crem0000.vto.HwaBookingVTO;

/**
 *
*
* 업무분류   : 화장관리
* 기능분류   : 화장 예약 현황 조회
* 프로그램명 : 화장 예약 현황 조회
* 설      명 : 화장 예약 현황 조회
* ------------------------------------------
*
* 이력사항 2017. 10. 6. 김동호 최초작성 <BR/>
 */
@Controller
public class CREM1020Controller extends BaseController {

	@Autowired
	private HwaBookingService hwaBookingService;

	@RequestMapping(value="/CREM1020/hwaBooking/page", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public PageableResponseParams.PageResponse findOneHwaCremation(
			@RequestParam Map<String, String> requestBody
			, Pageable pageable
			) throws Exception{

		Page<HwaBookingVTO> hwaBookingPage = hwaBookingService.findHwaBooking(requestBody, pageable);

		return PageableResponseParams.PageResponse.of(hwaBookingPage.getContent(),PageableTO.of(hwaBookingPage));
	}

	@RequestMapping(value="/CREM1020/hwaBooking", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public  Map<String, Object> findRogrpchasuByDate(@RequestParam Map<String, String> requestBody) throws ParseException{
		Map<String, Object> map = hwaBookingService.findRogrpchasuByDate(requestBody);

		return map;
	}

	@RequestMapping(value="/CREM1020/hwaBookingList", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public List<HwaBookingVTO> findBookingList(@RequestParam Map<String, String> requestBody) throws ParseException{
		List<HwaBookingVTO> list = hwaBookingService.findBookingList(requestBody);

		return list;
	}


}
