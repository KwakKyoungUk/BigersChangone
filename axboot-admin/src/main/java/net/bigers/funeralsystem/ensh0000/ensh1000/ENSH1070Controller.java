package net.bigers.funeralsystem.ensh0000.ensh1000;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.util.DozerBeanMapperUtils;

import net.bigers.funeralsystem.common.domain.applicant.Applicant;
import net.bigers.funeralsystem.common.domain.applicant.ApplicantService;
import net.bigers.funeralsystem.ensh0000.domain.enshrine.EnshrineService;
import net.bigers.funeralsystem.ensh0000.vto.EnshrineMapperVTO;


@Controller
public class ENSH1070Controller extends BaseController {

	@Autowired
	private EnshrineService enshrineService;

	@Autowired
	private ApplicantService applicantService;

	@RequestMapping(value="/ENSH1070/extEndDate", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse findOneHwaCremation(
			@RequestParam Map<String, String> requestBody
			) throws Exception{

		List<EnshrineMapperVTO> enshrinePage = enshrineService.findByExtEndDate(requestBody);

		return CommonListResponseParams.ListResponse.of(enshrinePage);
	}

	@RequestMapping(value="/ENSH1070/saveApplicant", method=RequestMethod.PUT, produces=APPLICATION_JSON)
	public ApiResponse saveApplicant(
			@RequestBody Applicant applicant
			) throws Exception{

		String applPost = applicant.getApplPost();
		String applAddr1 = applicant.getApplAddr1();
		String applAddr2= applicant.getApplAddr2();

		Applicant beforeAppl = applicantService.findOne(applicant.getId());
		applicant = DozerBeanMapperUtils.map(beforeAppl, Applicant.class);
		if(!applAddr1.equals(beforeAppl.getApplAddr1()) || !applAddr2.equals(beforeAppl.getApplAddr2())){
			applicant.setApplPost(applPost);
			applicant.setApplAddr1(applAddr1);
			applicant.setApplAddr2(applAddr2);
			applicantService.save(applicant, true, beforeAppl.getApplId());
		}

		return ok();
	}


}
