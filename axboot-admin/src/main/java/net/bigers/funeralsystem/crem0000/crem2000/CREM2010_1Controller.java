package net.bigers.funeralsystem.crem0000.crem2000;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.core.api.response.ApiResponse;

import net.bigers.funeralsystem.crem0000.domain.hwaOpenGrave.HwaOpenGrave;
import net.bigers.funeralsystem.crem0000.domain.hwaOpenGrave.HwaOpenGraveService;

/**
 *
 * 업무분류   : 화장
 * 기능분류   : 개장유골 고인 등록
 * 프로그램명 : 개장유골 고인등록 팝업
 * 설명 : 개장유골 여러건 입력시 동시에 입력 가능하도록하는 기능
 * ------------------------------------------
 *
 * 이력사항 2021. 3. 5. sh 최초작성<BR/>
 */
@Controller
public class CREM2010_1Controller extends BaseController {

	@Autowired
	private HwaOpenGraveService graveService;

	@RequestMapping(value="/CREM1010_1/hwa_open_grave", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public ListResponse getHwaOpenGrave(@DateTimeFormat(pattern="yyyy-MM-dd") Date cremDate, Integer cremSeq) {
		List<HwaOpenGrave> list = this.graveService.selectByCremDateAndCremSeq(cremDate, cremSeq);
		return ListResponse.of(list);
	}

	@RequestMapping(value="/CREM1010_1/hwa_open_grave", method=RequestMethod.PUT, produces=APPLICATION_JSON)
	public ApiResponse putHwaOpenGrave(@DateTimeFormat(pattern="yyyy-MM-dd") Date cremDate, Integer cremSeq, @RequestBody List<HwaOpenGrave> grave) {
		this.graveService.insertHwaOpenGrave(cremDate, cremSeq, grave);
		return ok();
	}

}
