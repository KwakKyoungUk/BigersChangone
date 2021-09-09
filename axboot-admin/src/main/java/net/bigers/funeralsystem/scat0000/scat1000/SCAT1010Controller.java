package net.bigers.funeralsystem.scat0000.scat1000;

import java.util.Date;
import java.util.HashMap;
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

import net.bigers.funeralsystem.common.domain.thedead.Thedead;
import net.bigers.funeralsystem.common.vto.ApplicantVTO;
import net.bigers.funeralsystem.fune0000.domain.dc_rate.DcRate;
import net.bigers.funeralsystem.fune0000.domain.dc_rate.DcRateService;
import net.bigers.funeralsystem.scat0000.domain.scatter.Scatter;
import net.bigers.funeralsystem.scat0000.domain.scatter.ScatterId;
import net.bigers.funeralsystem.scat0000.domain.scatter.ScatterService;
import net.bigers.funeralsystem.scat0000.vto.ScatterVTO;
import net.bigers.funeralsystem.stan0000.domain.pricelist.Pricelist;
import net.bigers.funeralsystem.stan0000.domain.pricelist.PricelistService;

/**
 *
*
* 업무분류   : 산골 관리
* 기능분류   : 산골 접수
* 프로그램명 : 산골 접수 관리
* 설      명 : 산골 접수 관리
* ------------------------------------------
*
* 이력사항 2016. 6. 30. SH 최초작성 <BR/>
 */
@Controller
public class SCAT1010Controller extends BaseController  {

	@Autowired
	private ScatterService scatterService;

	@Autowired
	private PricelistService pricelistService;

	@Autowired
	private DcRateService dcRateService;

	@RequestMapping(value="/SCAT1010/scatter/{scaDate}/{scaSeq}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse getScatter(
				@PathVariable("scaDate") @DateTimeFormat(pattern="yyyyMMdd") Date scaDate
				, @PathVariable("scaSeq") Integer scaSeq
			) throws Exception{
		Map<String, Object> result = new HashMap<>();
		result.put("scatterVTO", ScatterVTO.of(scatterService.findOne(ScatterId.of(scaDate, scaSeq))));
		return CommonListResponseParams.MapResponse.of(result);
	}

	@RequestMapping(value="/SCAT1010/scatter", method=RequestMethod.PUT, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse putScatter(
				@RequestBody Scatter scatter
			) throws Exception{
		Map<String, Object> result = scatterService.saveScatter(scatter);
		return CommonListResponseParams.MapResponse.of(result);
	}

	@RequestMapping(value="/SCAT1010/scatter/{scaDate}/{scaSeq}", method=RequestMethod.DELETE, produces=APPLICATION_JSON)
	public ApiResponse deleteScatter(
				@PathVariable("scaDate") @DateTimeFormat(pattern="yyyyMMdd") Date scaDate
				, @PathVariable("scaSeq") Integer scaSeq
			) throws Exception{
		scatterService.deleteScatter(ScatterId.of(scaDate, scaSeq));
		return ok();
	}

	@RequestMapping(value="/SCAT1010/applicant/{scaDate}/{scaSeq}/{applType}/{changeAddr}", method=RequestMethod.PUT, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse putApplicant(
			@PathVariable("scaDate") @DateTimeFormat(pattern="yyyyMMdd") Date scaDate
			, @PathVariable("scaSeq") Integer scaSeq
			, @PathVariable("applType") String applType
			, @PathVariable("changeAddr") boolean changeAddr
			, @RequestBody ApplicantVTO applicantVTO
			) throws Exception{
		return putApplicant(scaDate, scaSeq, applType, changeAddr, null, applicantVTO);
	}

	@RequestMapping(value="/SCAT1010/applicant/{scaDate}/{scaSeq}/{applType}/{changeAddr}/{beforeApplId}", method=RequestMethod.PUT, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse putApplicant(
			@PathVariable("scaDate") @DateTimeFormat(pattern="yyyyMMdd") Date scaDate
			, @PathVariable("scaSeq") Integer scaSeq
			, @PathVariable("applType") String applType
			, @PathVariable("changeAddr") boolean changeAddr
			, @PathVariable("beforeApplId") Integer beforeApplId
			, @RequestBody ApplicantVTO applicantVTO
			) throws Exception{

		Map<String, Object> result = scatterService.saveApplicant(ScatterId.of(scaDate, scaSeq), applType, changeAddr, beforeApplId, applicantVTO);

		return CommonListResponseParams.MapResponse.of(result);
	}

	@RequestMapping(value="/SCAT1010/pricelist/{addrPart}/{dcCode}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse getPriceList(
			@PathVariable("addrPart") String addrPart
			, @PathVariable("dcCode") String dcCode
			){
		/**
		 * "S" : 화장
		 * "U" : 사용료
		 * "TCM1000001" : 관내
		 * "TCM1200001" : 일반
		 */
		String jobGubun = "S";
		String priceGubun = "U";
		String objt = "TFM2700001";

		Pricelist generalPricelist = pricelistService.findPrice(jobGubun, priceGubun, objt, addrPart);
		//Pricelist generalPricelist = pricelistService.findPrice(jobGubun, priceGubun, objt, addrPart);
		Pricelist pricelist = pricelistService.findPrice(jobGubun,priceGubun, objt, addrPart);

		Map<String, Object> res = new HashMap<>();
		// 등록되지 않은 사용료는 관내 일반요금으로 계산
		if(generalPricelist == null){
			generalPricelist = pricelistService.findPrice(jobGubun, priceGubun, objt, "TCM1000001");
		}
		if(pricelist == null){
			pricelist = generalPricelist;
		}

		DcRate dcRate = dcRateService.findDcRate(jobGubun,dcCode);
		if(dcRate != null){
			generalPricelist = pricelistService.findPrice(jobGubun, priceGubun, objt, dcRate.getDcAddrPart());
		}

		res.put("pricelist", generalPricelist);
		res.put("generalPricelist", generalPricelist);

		return CommonListResponseParams.MapResponse.of(res);
	}

}
