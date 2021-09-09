package net.bigers.funeralsystem.ensh0000.ensh1000;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

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

import net.bigers.funeralsystem.common.Job;
import net.bigers.funeralsystem.common.domain.history.HistoryService;
import net.bigers.funeralsystem.common.vto.OptionVTO;
import net.bigers.funeralsystem.crem0000.domain.hwacremation.HwaCremationId;
import net.bigers.funeralsystem.crem0000.domain.hwacremation.HwaCremationService;
import net.bigers.funeralsystem.crem0000.vto.HwaCremationVTO;
import net.bigers.funeralsystem.ensh0000.domain.ensdead.Ensdead;
import net.bigers.funeralsystem.ensh0000.domain.ensdead.EnsdeadId;
import net.bigers.funeralsystem.ensh0000.domain.ensdead.EnsdeadService;
import net.bigers.funeralsystem.ensh0000.domain.enshrine.Enshrine;
import net.bigers.funeralsystem.ensh0000.domain.enshrine.EnshrineId;
import net.bigers.funeralsystem.ensh0000.domain.enshrine.EnshrineService;
import net.bigers.funeralsystem.ensh0000.domain.ensmap.Ensmap;
import net.bigers.funeralsystem.ensh0000.domain.ensmap.EnsmapService;
import net.bigers.funeralsystem.ensh0000.domain.ensret.Ensret;
import net.bigers.funeralsystem.ensh0000.domain.ensret.EnsretId;
import net.bigers.funeralsystem.ensh0000.domain.ensret.EnsretService;
import net.bigers.funeralsystem.ensh0000.vto.EnsdeadMoveVTO;
import net.bigers.funeralsystem.ensh0000.vto.EnshrineVTO;
import net.bigers.funeralsystem.ensh0000.vto.EnsretVTO;
import net.bigers.funeralsystem.fune0000.domain.dc_rate.DcRate;
import net.bigers.funeralsystem.fune0000.domain.dc_rate.DcRateService;
import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.stan0000.domain.pricelist.PricelistService;
import net.bigers.funeralsystem.stan0000.domain.retlist.Retlist;
import net.bigers.funeralsystem.stan0000.domain.retlist.RetlistService;
import net.bigers.funeralsystem.stan0000.vto.RetlistVTO;

/**
*
* 업무분류   : 봉안관리
* 기능분류   : 봉안 접수
* 프로그램명 : 봉안 접수 관리
* 설      명 : e하늘 화장예약 접수 또는 직접 접수
* ------------------------------------------
*
* 이력사항 2016. 6. 20. 이승호 최초작성 <BR/>
*/
@Controller
public class ENSH1010Controller extends BaseController  {

	@Autowired
	private EnshrineService enshrineService;

	@Autowired
	private EnsdeadService ensdeadService;

	@Autowired
	private EnsretService ensretService;

	@Autowired
	private PricelistService pricelistService;

	@Autowired
	private RetlistService retlistService;

	@Autowired
	private DcRateService dcRateService;

	@Autowired
	private EnsmapService ensmapService;

	@Autowired
	private HwaCremationService hwaCremationService;

	@RequestMapping(value="/ENSH1010/enshrine/{ensDate}/{ensSeq}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse getEnshrine(
				@PathVariable("ensDate") @DateTimeFormat(pattern="yyyy-MM-dd") Date ensDate
				, @PathVariable("ensSeq") Integer ensSeq
			) throws Exception{
		Map<String, Object> result = new HashMap<>();

		EnshrineVTO enshrine = enshrineService.findOneEnshrine(EnshrineId.of(ensDate, ensSeq));

		result.put("enshrine", enshrine);
		result.put("hwaCremation", hwaCremationService.findByEnsDateAndEnsSeq(ensDate, ensSeq));

		try {
			HistoryService.addHistory(String.format(
					"조회] 봉안접수자료(%s-%s) : 신청자 - %s"
					, DateUtils.formatToDateString(ensDate, "yyyy-MM-dd")
					, ensSeq
					, enshrine.getApplicant().getApplName()
					));
		}catch (Exception e) {
		}


		return CommonListResponseParams.MapResponse.of(result);
	}

	@RequestMapping(value="/ENSH1010/enshrine", method=RequestMethod.PUT, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse putEnshrine(
				@RequestBody Enshrine enshrine
			) throws Exception{
		Map<String, Object> result = enshrineService.saveEnshrine(enshrine);
		Date ensDate = DateUtils.parseDate(result.get("ensDate").toString(),"yyyy-MM-dd");
		Integer ensSeq = (Integer) result.get("ensSeq");
		Enshrine ens = enshrineService.findOne(EnshrineId.of(ensDate, ensSeq));
		List<Ensdead> ensdead = ensdeadService.findByEnsDateAndEnsSeq(ensDate, ensSeq);
		Ensmap ensmap = ensmapService.findOne(ens.getEnsNo());
		ensmap.setEnsCnt(ensdead.size());
		ensmapService.save(ensmap);

		try {
			HistoryService.addHistory(String.format(
					"저장] 봉안접수자료(%s-%s) : 신청자 - %s"
					, result.get("ensDate")
					, ensSeq
					, ens.getApplicant().getApplName()
					));
		}catch (Exception e) {
		}


		return CommonListResponseParams.MapResponse.of(result);
	}

	@RequestMapping(value="/ENSH1010/enshrine/{ensDate}/{ensSeq}", method=RequestMethod.DELETE, produces=APPLICATION_JSON)
	public ApiResponse deleteEnshrine(
			@PathVariable("ensDate") @DateTimeFormat(pattern="yyyy-MM-dd") Date ensDate
			, @PathVariable("ensSeq") Integer ensSeq
			) throws Exception{
		enshrineService.deleteEnshrine(EnshrineId.of(ensDate, ensSeq));

		try {
			HistoryService.addHistory(String.format(
					"삭제] 봉안접수자료(%s-%s)"
					, DateUtils.formatToDateString(ensDate, "yyyy-MM-dd")
					, ensSeq
					));
		}catch (Exception e) {
		}


		return ok();
	}

	@RequestMapping(value="/ENSH1010/ensdead/{ensDate}/{ensSeq}/{deadSeq}", method=RequestMethod.DELETE, produces=APPLICATION_JSON)
	public ApiResponse deleteEnsdead(
				@PathVariable("ensDate")  String ensDate
				, @PathVariable("ensSeq") Integer ensSeq
				, @PathVariable("deadSeq") Integer deadSeq
			) throws Exception{

		ensdeadService.deleteEnsdead(EnsdeadId.of(DateUtils.parseDate(ensDate.replaceAll("-", ""), "yyyyMMdd"), ensSeq, deadSeq));

		try {
			HistoryService.addHistory(String.format(
					"삭제] 봉안고인삭제(%s-%s-%s)"
					, ensDate
					, ensSeq
					, deadSeq
					));
		}catch (Exception e) {
		}


		return ok();
	}

	@RequestMapping(value="/ENSH1010/ensret", method=RequestMethod.PUT, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse putEnsret(
				@RequestBody EnsretVTO ensret
			) throws Exception{

		Map<String, Object> res = new HashMap<>();

		Ensret ret = ensretService.saveEnsret(ensret);

		res.put("ensret", ret);

		try {
			HistoryService.addHistory(String.format(
					"저장] 봉안반환(%s-%s)"
					, DateUtils.formatToDateString(ret.getEnsDate(), "yyyy-MM-dd")
					, ret.getEnsSeq()
					));
		}catch (Exception e) {
		}


		return CommonListResponseParams.MapResponse.of(res);
	}

	@ApiOperation(value="봉안반환취소", notes="삭제] 봉안반환취소({P0:}-{P1:})")
	@RequestMapping(value="/ENSH1010/ensret/{retDate}/{retSeq}", method=RequestMethod.DELETE, produces=APPLICATION_JSON)
	public ApiResponse deleteEnsret(
			@PathVariable("retDate") @DateTimeFormat(pattern="yyyyMMdd") Date retDate
			, @PathVariable("retSeq") Integer retSeq
			) throws Exception{

		ensretService.deleteEnsret(ensretService.findOne(EnsretId.of(retDate, retSeq)));

		try {
			HistoryService.addHistory(String.format(
					"삭제] 봉안반환취소(%s-%s)"
					, DateUtils.formatToDateString(retDate, "yyyy-MM-dd")
					, retSeq
					));
		}catch (Exception e) {
		}


		return ok();
	}

	@RequestMapping(value="/ENSH1010/retlist/{strDate}/{retnDate}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse getRetlist(
			@PathVariable("strDate") @DateTimeFormat(pattern="yyyyMMdd") Date strDate,
			@PathVariable("retnDate") @DateTimeFormat(pattern="yyyyMMdd") Date retnDate
			){
		/**
		 * "2" : 봉안
		 * "1" : 사용료
		 */
		Retlist retlist = retlistService.findRet("E", "U", strDate,retnDate);

		Map<String, Object> res = new HashMap<>();

		res.put("retlistVTO", RetlistVTO.of(retlist));

		return CommonListResponseParams.MapResponse.of(res);
	}


	@RequestMapping(value="/ENSH1010/dcCode", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public List<OptionVTO> getDcCode() throws Exception{
		List<DcRate> dcRates = this.dcRateService.findByJobGubun(Job.봉안.code());
		 List<OptionVTO> result = new ArrayList<>();
		 dcRates.forEach((item)->{
			result.add(OptionVTO.of(item.getDcCode(), item.getDcName()));
		});
		return result;
	}

//	@RequestMapping(value="/ENSH1010/pricelist", method=RequestMethod.GET, produces=APPLICATION_JSON)
//	public MapResponse getPricelist(
//			String ensKind
//			, String addrPart
//			) throws Exception{
//
//		Pricelist usePrice = this.pricelistService.getCurrentPrice(Job.봉안.code(), PriceGubun.사용료.code(), ensKind, addrPart);
//		Pricelist mngPrice = this.pricelistService.getCurrentPrice(Job.봉안.code(), PriceGubun.관리비.code(), ensKind, addrPart);
//
//		Map<String, Object> res = MapUtils.getMap("usePrice", usePrice);
//		res.put("mngPrice", mngPrice);
//
//		return MapResponse.of(res);
//	}


	@RequestMapping(value="/ENSH1010/price", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public MapResponse getCalcPrice(
			String ensType
			, @DateTimeFormat(pattern="yyyy-MM-dd") Date transferDate
			, String dcGubun
			, String addrPart
			, String objt
			, String dcCode
			) throws Exception{

		return MapResponse.of(MapUtils.getMap("price", this.pricelistService.getPriceOfEnshrine(ensType, transferDate, dcGubun, addrPart, objt, dcCode)));
	}

	@RequestMapping(value="/ENSH1010/hwaCremation", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse findOneHwaCremation(
			String area
			, @DateTimeFormat(pattern="yyyy-MM-dd") Date cremDate
			, Integer cremSeq
			) throws Exception{

		HwaCremationVTO hwaCremationVTO = hwaCremationService.findOneHwaCremation(area, HwaCremationId.of(cremDate, cremSeq));

		if(Objects.isNull(hwaCremationVTO)){
			throw new Exception("검색 결과가 존재하지 않습니다.");
		}

		Map<String, Object> map = new HashMap<>();

		if(hwaCremationVTO.getEnsDate() != null){
			map.put("enshrine",  enshrineService.findOne(EnshrineId.of(hwaCremationVTO.getEnsDate(), hwaCremationVTO.getEnsSeq())));
		//.setEnshrine(enshrineService.findOne(EnshrineId.of(hwaCremationVTO.getEnsDate(), hwaCremationVTO.getEnsSeq())));
		}


		map.put("hwaCremationVTO", hwaCremationVTO);

		return CommonListResponseParams.MapResponse.of(map);
	}

	@RequestMapping(value="/ENSH1010/ens-no", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse getNextEnsNo(String ensType){

		Map<String, Object> res = new HashMap<>();

		String ensNo = this.hwaCremationService.getNextEnsNo(ensType);

		res.put("ensNo", ensNo);

		return MapResponse.of(res);
	}

	@RequestMapping(value="/ENSH1010/move/couple/data", method=RequestMethod.POST, produces=APPLICATION_JSON)
	public ApiResponse moveCoupleData(
			@RequestBody EnsdeadMoveVTO moveVTO
			){

		this.enshrineService.moveCoupleData(EnshrineId.of(moveVTO.getFromEnsDate(), moveVTO.getFromEnsSeq()), EnshrineId.of(moveVTO.getToEnsDate(), moveVTO.getToEnsSeq()));

		return ok();
	}
}
