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
import com.axisj.axboot.core.domain.code.BasicCodeService;

import net.bigers.funeralsystem.stat0000.STAT1310Mapper;
import net.bigers.funeralsystem.stat0000.STAT1310VTO;

/**
*
* 업무분류   : 통계관리
* 기능분류   : 통계관리
* 프로그램명 : 일자별 화장 및 봉안현황
* 설      명 : 일자별 화장 및 봉안현황
* ------------------------------------------
*
* 이력사항 2018. 3. 22. 김세현 최초작성 <BR/>
*/
@Controller
public class STAT1310Controller extends BaseController {

	@Autowired
	private BasicCodeService basicCodeService;

	@Inject
	private STAT1310Mapper statMapper;

	@RequestMapping(value="/stat1310/getList", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getList(@RequestParam Map<String, String> requestBody) throws Exception{
		List<STAT1310VTO> list = statMapper.getSTAT1310List(requestBody);
		return CommonListResponseParams.ListResponse.of(list);

	}
}
