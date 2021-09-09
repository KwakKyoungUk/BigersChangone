package net.bigers.funeralsystem.stat0000.stat1000;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;

import net.bigers.funeralsystem.stat0000.STAT1060Mapper;
import net.bigers.funeralsystem.stat0000.STAT1060VTO;

/**
*
* 업무분류   : 통계관리
* 기능분류   : 통계관리
* 프로그램명 : 일자별 화장 및 봉안현황
* 설      명 : 일자별 화장 및 봉안현황
* ------------------------------------------
*
* 이력사항 2018. 2. 13. 김은호 최초작성 <BR/>
*/
@Controller
public class STAT1060Controller extends BaseController {

	@Autowired
	private BasicCodeService basicCodeService;

	@Inject
	private STAT1060Mapper statMapper;

	@RequestMapping(value="/stat1060/dc_gubun", method=RequestMethod.POST, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getDcGubun() throws Exception{

		List<BasicCode> list = basicCodeService.findByBasicCd("TCM12");

		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/stat1060/location_gubun", method=RequestMethod.POST, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getKwanGubun() throws Exception{

		List<BasicCode> list = basicCodeService.findByBasicCd("TCM04");
		return CommonListResponseParams.ListResponse.of(list);

	}

	@RequestMapping(value="/stat1060/getList", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getList(@RequestParam Map<String, String> requestBody) throws Exception{
		List<STAT1060VTO> list = statMapper.getSTAT1060List(requestBody);
		return CommonListResponseParams.ListResponse.of(list);

	}
}
