package net.bigers.funeralsystem.crem0000.crem1000;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.core.api.response.ApiResponse;

import net.bigers.funeralsystem.crem0000.domain.hwabooking.HwaBooking;
import net.bigers.funeralsystem.crem0000.domain.hwabooking.HwaBookingId;
import net.bigers.funeralsystem.crem0000.domain.hwabooking.HwaBookingService;
import net.bigers.funeralsystem.crem0000.vto.HwaBookingVTO;

/**
*
* 업무분류   : 화장관리
* 기능분류   : 화장 예약 접수
* 프로그램명 : 화장예약 변경
* 설      명 : 화장예약 변경
* ------------------------------------------
*
* 이력사항 2016. 6. 14. 이승호 최초작성 <BR/>
*/
@Controller
public class CREM1011Controller extends BaseController {

	@Autowired
	private HwaBookingService hwaBookingService;

	@RequestMapping(value="/CREM1011/hwaBooking", method=RequestMethod.PUT, produces=APPLICATION_JSON)
	@Transactional
	public ApiResponse changeKeyRogrpchasu(
				@RequestBody HwaBookingVTO hwaBookingVTO
			) throws Exception{

		HwaBooking before = hwaBookingService.findOne(HwaBookingId.of(hwaBookingVTO.getBeforeBookDate(), hwaBookingVTO.getBeforeBookChasu(), hwaBookingVTO.getBeforeBookChasuSeq()));
		hwaBookingService.delete(before);
		before.setBookDate(hwaBookingVTO.getBookDate());
		before.setBookChasu(hwaBookingVTO.getBookChasu());
		before.setBookChasuSeq(hwaBookingVTO.getBookChasuSeq());
		hwaBookingService.save(before.clone());

		return ok();
	}

}
