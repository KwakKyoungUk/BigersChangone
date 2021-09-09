package net.bigers.funeralsystem.scat0000.scat1000;

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

import net.bigers.funeralsystem.scat0000.domain.scatter.Scatter;
import net.bigers.funeralsystem.scat0000.domain.scatter.ScatterService;
import net.bigers.funeralsystem.scat0000.vto.ScatterVTO;

/**
 *
*
* 업무분류   : 산골 관리
* 기능분류   : 산골 접수 현황 조회
* 프로그램명 : 산골 접수 현황
* 설      명 : 산골 접수 현황 조회
* ------------------------------------------
*
* 이력사항 2016. 7. 1. SH 최초작성 <BR/>
 */
@Controller
public class SCAT1020Controller extends BaseController {

	@Autowired
	private ScatterService scatterService;

	@RequestMapping(value="/SCAT1020/scatter", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public PageableResponseParams.PageResponse findOneHwaCremation(
			@RequestParam Map<String, String> requestBody
			, Pageable pageable
			) throws Exception{

		Page<Scatter> scatterPage = scatterService.findScatter(requestBody, pageable);

		return PageableResponseParams.PageResponse.of(ScatterVTO.of(scatterPage.getContent()), PageableTO.of(scatterPage));
	}


}
