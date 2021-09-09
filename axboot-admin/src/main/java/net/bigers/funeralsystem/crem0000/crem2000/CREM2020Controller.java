package net.bigers.funeralsystem.crem0000.crem2000;

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
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.admin.parameter.PageableResponseParams;
import com.axisj.axboot.core.dto.PageableTO;

import net.bigers.funeralsystem.crem0000.domain.hwacremation.HwaCremation;
import net.bigers.funeralsystem.crem0000.domain.hwacremation.HwaCremationService;
import net.bigers.funeralsystem.crem0000.vto.HwaCremationVTO;

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
public class CREM2020Controller extends BaseController {

	@Autowired
	private HwaCremationService hwaCremationService;

	@RequestMapping(value="/CREM2020/hwaCremation", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getHwaCremation(
			@RequestParam Map<String, String> requestBody
			, Pageable pageable
			) throws Exception{

		List<HwaCremationVTO> list = hwaCremationService.getHwaCremation(requestBody);

		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/CREM2020/searchHwaCremationThedead", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public PageableResponseParams.PageResponse findHwaCremation(
			@RequestParam Map<String, String> requestBody
			, Pageable pageable
			) throws Exception{

		Page<HwaCremation> hwaCremationPage = hwaCremationService.findHwaCremationThedead(requestBody, pageable);

		return PageableResponseParams.PageResponse.of(HwaCremationVTO.of(hwaCremationPage.getContent()), PageableTO.of(hwaCremationPage));
	}

}
