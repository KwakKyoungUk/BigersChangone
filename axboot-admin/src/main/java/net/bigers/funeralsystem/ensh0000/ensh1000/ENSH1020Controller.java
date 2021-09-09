package net.bigers.funeralsystem.ensh0000.ensh1000;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;

import net.bigers.funeralsystem.ensh0000.domain.enshrine.EnshrineService;
import net.bigers.funeralsystem.ensh0000.vto.EnshrineMapperVTO;

/**
 *
*
* 업무분류   : 봉안관리
* 기능분류   : 봉안 접수 현황 조회
* 프로그램명 : 봉안관리
* 설      명 : 봉안 접수 현황 조회
* ------------------------------------------
*
* 이력사항 2016. 6. 29. SH 최초작성 <BR/>
 */
@Controller
public class ENSH1020Controller extends BaseController {

	@Autowired
	private EnshrineService enshrineService;

	@RequestMapping(value="/ENSH1020/enshrine", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse findOneHwaCremation(
			@RequestParam Map<String, String> requestBody
			, Pageable pageable
			) throws Exception{

		//Page<EnshrineMapperVTO> enshrinePage = enshrineService.findEnshrine(requestBody, pageable);
		List<EnshrineMapperVTO> enshrinePage = enshrineService.findEnshrine(requestBody, pageable);

		return CommonListResponseParams.ListResponse.of(enshrinePage);
		//return PageableResponseParams.PageResponse.of(enshrinePage.getContent(), PageableTO.of(enshrinePage));
	}


}
