package net.bigers.funeralsystem.ensh0000.ensh1000;

import java.util.HashMap;
import java.util.Map;

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
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.admin.parameter.PageableResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.dto.PageableTO;
import com.axisj.axboot.core.util.DozerBeanMapperUtils;

import net.bigers.funeralsystem.common.domain.applicant.Applicant;
import net.bigers.funeralsystem.common.domain.applicant.ApplicantService;
import net.bigers.funeralsystem.common.domain.thedead.Thedead;
import net.bigers.funeralsystem.common.vto.ApplicantVTO;
import net.bigers.funeralsystem.common.vto.ThedeadVTO;
import net.bigers.funeralsystem.lib.util.SpringUtils;

/**
*
* 업무분류   : 봉안관리
* 기능분류   : 신청자검색
* 프로그램명 : 봉안 접수 관리
* 설      명 : 신청자검색 팝업
* ------------------------------------------
*
* 이력사항 2016. 6. 21. 이승호 최초작성 <BR/>
*/
@Controller
public class ENSH1012Controller extends BaseController  {

	@Autowired
	private ApplicantService applicantService;

	@RequestMapping(value="/ENSH1012/applicant/{condition}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public PageableResponseParams.PageResponse getApplicant(
			@PathVariable("condition") String condition
			, Pageable pageable
			) throws Exception{

		return getApplicant(condition, null, pageable);
	}

	@RequestMapping(value="/ENSH1012/applicant/{condition}/{keyword}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public PageableResponseParams.PageResponse getApplicant(
			@PathVariable("condition") String condition
			, @PathVariable("keyword") String keyword
			, Pageable pageable
			) throws Exception{
		Page<Applicant> applicantList = applicantService.findApplicant(condition, keyword, pageable);
		return PageableResponseParams.PageResponse.of(ApplicantVTO.of(applicantList.getContent()), PageableTO.of(applicantList));
	}

	@RequestMapping(value="/ENSH1012/applicant/{change}", method={RequestMethod.POST, RequestMethod.PUT}, produces=APPLICATION_JSON)
	public Object putApplicant(
			@PathVariable("change") boolean change
			, @RequestBody ApplicantVTO applicantVTO
			) throws Exception{

		Applicant applicant = applicantService.save(DozerBeanMapperUtils.map(applicantVTO, Applicant.class), change, null);
		
		return ApplicantVTO.of(applicant);
	}	
	
	
	@RequestMapping(value="/ENSH1012/applicant/", method=RequestMethod.PUT, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse isNewApplicant(
			@RequestBody ApplicantVTO applicantVTO		
			) throws Exception{
		
		Map<String,Object> map = new HashMap<>();
		Applicant applicant = applicantService.isNewApplicant(applicantVTO.getApplJumin());
		map.put("isNew", applicant == null);
		map.put("applicantVTO",ApplicantVTO.of(applicant));
		return CommonListResponseParams.MapResponse.of(map);
	}
}
