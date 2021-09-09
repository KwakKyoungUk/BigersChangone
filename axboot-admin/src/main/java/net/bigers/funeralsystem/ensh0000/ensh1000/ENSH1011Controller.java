package net.bigers.funeralsystem.ensh0000.ensh1000;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.PageableResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.dto.PageableTO;
import com.axisj.axboot.core.util.DozerBeanMapperUtils;

import net.bigers.funeralsystem.common.domain.thedead.Thedead;
import net.bigers.funeralsystem.common.domain.thedead.ThedeadService;
import net.bigers.funeralsystem.common.vto.ThedeadVTO;

/**
*
* 업무분류   : 봉안관리
* 기능분류   : 고인검색
* 프로그램명 : 봉안 접수 관리
* 설      명 : 고인검색 팝업
* ------------------------------------------
*
* 이력사항 2016. 6. 20. 이승호 최초작성 <BR/>
*/
@Controller
public class ENSH1011Controller extends BaseController  {

	@Autowired
	private ThedeadService thedeadService;

	@RequestMapping(value="/ENSH1011/thedead/{condition}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public PageableResponseParams.PageResponse getThedead(
			@PathVariable("condition") String condition
			, Pageable pageable
			) throws Exception{

		return getThedead(condition, null,null, pageable);
	}

	@RequestMapping(value="/ENSH1011/thedead/{condition}/{keyword}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public PageableResponseParams.PageResponse getThedead(
			@PathVariable("condition") String condition
			, @PathVariable("keyword") String keyword
			, @RequestParam(value="keyword2") String keyword2
			, Pageable pageable
			) throws Exception{
		Page<Thedead> thedeadList = thedeadService.findThedead(condition, keyword,keyword2, pageable);
		return PageableResponseParams.PageResponse.of(ThedeadVTO.of(thedeadList.getContent()), PageableTO.of(thedeadList));
	}

	@RequestMapping(value="/ENSH1011/thedead", method={RequestMethod.POST, RequestMethod.PUT}, produces=APPLICATION_JSON)
	public Object putThedead(
			@RequestBody ThedeadVTO thedeadVTO
			) throws Exception{

		Thedead thedead = thedeadService.save(DozerBeanMapperUtils.map(thedeadVTO, Thedead.class));
		
		return ThedeadVTO.of(thedead);
	}

}
