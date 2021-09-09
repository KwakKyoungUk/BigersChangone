package net.bigers.funeralsystem.ensh0000.ensh1000;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;

import net.bigers.funeralsystem.common.domain.applicant.Applicant;
import net.bigers.funeralsystem.common.domain.applicant.ApplicantService;
import net.bigers.funeralsystem.ensh0000.domain.enshrine.EnshrineId;
import net.bigers.funeralsystem.ensh0000.domain.enshrine.EnshrineService;
import net.bigers.funeralsystem.ensh0000.domain.enssucced.Enssucced;
import net.bigers.funeralsystem.ensh0000.domain.enssucced.EnssuccedId;
import net.bigers.funeralsystem.ensh0000.domain.enssucced.EnssuccedService;

/**
*
* 업무분류   : 봉안관리
* 기능분류   : 승계처리
* 프로그램명 : 봉안 접수 관리
* 설      명 : 승계처리
* ------------------------------------------
*
* 이력사항 2016. 6. 27. 이승호 최초작성 <BR/>
*/
@Controller
public class ENSH1015Controller extends BaseController  {

	@Autowired
	private ApplicantService applicantService;

	@Autowired
	private EnssuccedService enssuccedService;

	@Autowired
	private EnshrineService enshrineService;

	@RequestMapping(value="/ENSH1015/enssucced/{ensDate}/{ensSeq}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getEnssucced(
				@PathVariable("ensDate") @DateTimeFormat(pattern="yyyy-MM-dd") Date ensDate
				, @PathVariable("ensSeq") Integer ensSeq
			) throws Exception{

		List<Enssucced> enssuccedList = enssuccedService.findByEnsDateAndEnsSeq(ensDate, ensSeq);

		return CommonListResponseParams.ListResponse.of(enssuccedList);
	}

	@RequestMapping(value="/ENSH1015/applicant/{applId}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse getEnssucced(
				@PathVariable("applId") Integer applId
			) throws Exception{

		Applicant applicant = applicantService.findOne(applId);

		Map<String, Object> res = new HashMap<>();

		res.put("applicant", applicant);

		return CommonListResponseParams.MapResponse.of(res);
	}

	@RequestMapping(value="/ENSH1015/enshrine/{ensDate}/{ensSeq}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse getEnshrine(
			@PathVariable("ensDate") @DateTimeFormat(pattern="yyyy-MM-dd") Date ensDate
			, @PathVariable("ensSeq") Integer ensSeq
			) throws Exception{

		Map<String, Object> res = new HashMap<>();

		res.put("enshrine", enshrineService.findOne(EnshrineId.of(ensDate, ensSeq)));

		return CommonListResponseParams.MapResponse.of(res);
	}

	@RequestMapping(value="/ENSH1015/enssucced/{changePayer}", method=RequestMethod.PUT, produces=APPLICATION_JSON)
	public ApiResponse putEnssucced(
				@RequestBody Enssucced enssucced
				, @PathVariable("changePayer") boolean changePayer
			) throws Exception{
		enssuccedService.saveEnssucced(enssucced, changePayer);
		return ok();
	}

	@RequestMapping(value="/ENSH1015/enssucced/{ensDate}/{ensSeq}/{succDate}", method=RequestMethod.DELETE, produces=APPLICATION_JSON)
	public ApiResponse deleteEnsext(
				@PathVariable("ensDate") @DateTimeFormat(pattern="yyyy-MM-dd") Date ensDate
				, @PathVariable("ensSeq") Integer ensSeq
				, @PathVariable("succDate") @DateTimeFormat(pattern="yyyy-MM-dd") Date succDate
			) throws Exception{
		enssuccedService.deleteEnssucced(EnssuccedId.of(ensDate, ensSeq, succDate));
		return ok();
	}


}
