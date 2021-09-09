package net.bigers.funeralsystem.crem0000.crem2000;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;

import net.bigers.funeralsystem.ensh0000.domain.enshrine.Enshrine;
import net.bigers.funeralsystem.ensh0000.domain.enshrine.EnshrineService;
import net.bigers.funeralsystem.ensh0000.vto.CREM2010_2VTO;

/**
 *
 * 업무분류   : 화장
 * 기능분류   : 화장에서 봉안 부부단 배우자 접수
 * 프로그램명 : 부부단 배우자 봉안 자료 검색
 * 설명 :
 * ------------------------------------------
 *
 * 이력사항 2021. 4. 15. sh 최초작성<BR/>
 */
@Controller
public class CREM2010_2Controller extends BaseController {

	@Autowired
	private EnshrineService enshrineService;

	@RequestMapping(value="/CREM2010_2/enshrine/couple", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public ListResponse getCoupleEnshrine(@DateTimeFormat(pattern="yyyy-MM-dd") Date ensDate, String deadName) {
		List<CREM2010_2VTO> enshrine = this.enshrineService.selectEnshrineByEnsDateAndDeadName(ensDate, deadName);
		return ListResponse.of(enshrine);
	}

}
