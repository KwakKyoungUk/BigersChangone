package net.bigers.funeralsystem.stat0000.stat1000;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;

/**
*
* 업무분류   : 통계관리
* 기능분류   : 통계관리
* 프로그램명 : 감면자화장및봉안현황
* 설      명 : 감면자화장및봉안현황
* ------------------------------------------
*
* 이력사항 2018. 1. 16. 김은호 최초작성 <BR/>
*/
@Controller
public class STAT1080Controller extends BaseController {

	@Autowired
	private BasicCodeService basicCodeService;

	@RequestMapping(value="/stat1080/dc_gubun", method=RequestMethod.POST, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getDcGubun() throws Exception{

		List<BasicCode> list = basicCodeService.findByBasicCd("TCM12");

		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/stat1080/kwan_gubun", method=RequestMethod.POST, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getKwanGubun() throws Exception{

		List<BasicCode> list = basicCodeService.findByBasicCd("TCM10");
		return CommonListResponseParams.ListResponse.of(list);

	}
}
