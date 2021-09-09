package net.bigers.funeralsystem.ensh0000.ensh1000;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.util.DateUtils;
import com.wordnik.swagger.annotations.ApiOperation;

import net.bigers.funeralsystem.common.domain.history.HistoryService;
import net.bigers.funeralsystem.ensh0000.domain.ensext.Ensext;
import net.bigers.funeralsystem.ensh0000.domain.ensext.EnsextId;
import net.bigers.funeralsystem.ensh0000.domain.ensext.EnsextService;
import net.bigers.funeralsystem.ensh0000.domain.enshrine.EnshrineService;
import net.bigers.funeralsystem.ensh0000.vto.EnsextVTO2;
import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.stan0000.domain.pricelist.PricelistService;

/**
*
* 업무분류   : 봉안관리
* 기능분류   : 봉안 연장
* 프로그램명 : 봉안 접수 관리
* 설      명 : 봉안 연장
* ------------------------------------------
*
* 이력사항 2016. 6. 23. 이승호 최초작성 <BR/>
*/
@Controller
public class ENSH1014Controller extends BaseController  {

	@Autowired
	private EnshrineService enshrineService;

	@Autowired
	private EnsextService ensextService;

	@Autowired
	private PricelistService pricelistService;

	@RequestMapping(value="/ENSH1014/ensext/{ensDate}/{ensSeq}/{deadSeq}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getEnsext(
				@PathVariable("ensDate") @DateTimeFormat(pattern="yyyy-MM-dd") Date ensDate
				, @PathVariable("ensSeq") Integer ensSeq
				, @PathVariable("deadSeq") Integer deadSeq
			) throws Exception{

		List<Ensext> ensextList = ensextService.findByEnsDateAndEnsSeqAndDeadSeq(ensDate, ensSeq, deadSeq);
		try {
			HistoryService.addHistory("조회] 봉안연장조회("+DateUtils.formatToDateString(ensDate, "yyyy-MM-dd")+"-"+ensSeq+"-"+ensSeq+")");
		}catch (Exception e) {
		}

		return CommonListResponseParams.ListResponse.of(ensextList);
	}

	@RequestMapping(value="/ENSH1014/ensext", method=RequestMethod.PUT, produces=APPLICATION_JSON)
	public ApiResponse putEnsext(
				@RequestBody EnsextVTO2 ensext
			) throws Exception{
		enshrineService.extEnshrine(ensext);
		try {
			HistoryService.addHistory(String.format(
					"저장] 봉안연장(%s-%s) 신청자 - %s"
					, DateUtils.formatToDateString(ensext.getEnsext().getEnsDate(), "yyyy-MM-dd")
					, ensext.getEnsext().getEnsSeq()
					, ensext.getApplicant().getApplName()
					));
		}catch (Exception e) {
		}

		return ok();
	}

	@RequestMapping(value="/ENSH1014/ensext/{extDate}/{extSeq}", method=RequestMethod.DELETE, produces=APPLICATION_JSON)
	public ApiResponse deleteEnsext(
				@PathVariable("extDate") @DateTimeFormat(pattern="yyyy-MM-dd") Date extDate
				, @PathVariable("extSeq") Integer extSeq
			) throws Exception{
		enshrineService.deleteExtEnshrine(EnsextId.of(extDate, extSeq));
		try {
			HistoryService.addHistory(String.format(
					"삭제] 봉안연장삭제(%s-%s)"
					, DateUtils.formatToDateString(extDate, "yyyy-MM-dd")
					, extSeq
					));
		}catch (Exception e) {
		}

		return ok();
	}

	@RequestMapping(value="/ENSH1014/price", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public MapResponse getCalcPrice(
			@DateTimeFormat(pattern="yyyy-MM-dd") Date ensDate
			, Integer ensSeq
			, Integer deadSeq
			, Integer unpaidCalc
			) throws Exception{

		return MapResponse.of(MapUtils.getMap("price", this.pricelistService.getPriceOfEnsext(ensDate, ensSeq, deadSeq, unpaidCalc)));
	}

}
