package net.bigers.funeralsystem.crem0000.crem2000;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

import org.apache.commons.lang.StringUtils;
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

import net.bigers.funeralsystem.common.domain.addrpart.Addrpart;
import net.bigers.funeralsystem.common.domain.addrpart.AddrpartService;
import net.bigers.funeralsystem.common.domain.applicant.ApplicantService;
import net.bigers.funeralsystem.common.domain.history.HistoryService;
import net.bigers.funeralsystem.common.domain.thedead.Thedead;
import net.bigers.funeralsystem.common.vto.AddrpartVTO;
import net.bigers.funeralsystem.common.vto.OptionVTO;
import net.bigers.funeralsystem.crem0000.domain.hwabooking.HwaBooking;
import net.bigers.funeralsystem.crem0000.domain.hwabooking.HwaBookingId;
import net.bigers.funeralsystem.crem0000.domain.hwabooking.HwaBookingService;
import net.bigers.funeralsystem.crem0000.domain.hwacremation.HwaCremationId;
import net.bigers.funeralsystem.crem0000.domain.hwacremation.HwaCremationService;
import net.bigers.funeralsystem.crem0000.domain.rogrp.RogrpService;
import net.bigers.funeralsystem.crem0000.domain.rogrpchasu.RogrpchasuService;
import net.bigers.funeralsystem.crem0000.vto.HwaBookingVTO;
import net.bigers.funeralsystem.crem0000.vto.HwaCremationVTO;
import net.bigers.funeralsystem.ensh0000.domain.enshrine.EnshrineId;
import net.bigers.funeralsystem.ensh0000.domain.enshrine.EnshrineService;
import net.bigers.funeralsystem.fune0000.domain.dc_rate.DcRate;
import net.bigers.funeralsystem.fune0000.domain.dc_rate.DcRateService;
import net.bigers.funeralsystem.fune0000.domain.funeral.Funeral;
import net.bigers.funeralsystem.fune0000.domain.funeral.FuneralService;
import net.bigers.funeralsystem.fune0000.domain.payment.Payment;
import net.bigers.funeralsystem.fune0000.domain.payment.PaymentService;
import net.bigers.funeralsystem.stan0000.domain.pricelist.Pricelist;
import net.bigers.funeralsystem.stan0000.domain.pricelist.PricelistService;

/**
*
* 업무분류   : 화장관리
* 기능분류   : 화장 예약 접수
* 프로그램명 : 화장예약 변경
* 설      명 : 화장예약 변경
* ------------------------------------------
*
* 이력사항 2016. 6. 14. 이승호 최초작성 <BR/>
*/
@Controller
public class CREM2010Controller extends BaseController {

	@Autowired
	private HwaCremationService hwaCremationService;

	@Autowired
	private HwaBookingService hwaBookingService;

	@Autowired
	private AddrpartService addrpartService;

	@Autowired
	private PricelistService pricelistService;

	@Autowired
	private ApplicantService applicantService;

	@Autowired
	private RogrpService rogrpService;

	@Autowired
	private RogrpchasuService rogrpchasuService;

	@Autowired
	private DcRateService dcRateService;

	@Autowired
	private EnshrineService enshrineService;

	@Autowired
	private FuneralService funeralService;

	@Autowired
	private PaymentService paymentService;

	@RequestMapping(value="/CREM2010/hwaCremation/{cremDate}/{cremSeq}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse findOneHwaCremation(
			@PathVariable("cremDate") @DateTimeFormat(pattern="yyyy-MM-dd") Date cremDate
			, @PathVariable("cremSeq") Integer cremSeq
			) throws Exception{

		HwaCremationVTO hwaCremationVTO = hwaCremationService.findOneHwaCremation(HwaCremationId.of(cremDate, cremSeq));

		if(Objects.isNull(hwaCremationVTO)){
			throw new Exception("검색 결과가 존재하지 않습니다.");
		}

		Map<String, Object> map = new HashMap<>();

		if(hwaCremationVTO.getEnsDate() != null){
			map.put("enshrine",  enshrineService.findOne(EnshrineId.of(hwaCremationVTO.getEnsDate(), hwaCremationVTO.getEnsSeq())));
		//.setEnshrine(enshrineService.findOne(EnshrineId.of(hwaCremationVTO.getEnsDate(), hwaCremationVTO.getEnsSeq())));
		}


		map.put("hwaCremationVTO", hwaCremationVTO);

		try {
			HistoryService.addHistory(String.format(
					"조회] 화장접수자료(%s-%s) : 신청자 - %s}"
					, DateUtils.formatToDateString(cremDate, "yyyy-MM-dd")
					, cremSeq
					, hwaCremationVTO.getApplicant().getApplName()
					));
		}catch (Exception e) {
		}


		return CommonListResponseParams.MapResponse.of(map);
	}

	@RequestMapping(value="/CREM2010/hwaBooking/{bookDate}/{bookChasu}/{bookChasuSeq}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse findOneHwaBooking(
			@PathVariable("bookDate") String bookDate
			, @PathVariable("bookChasu") String bookChasu
			, @PathVariable("bookChasuSeq") String bookChasuSeq
			) throws Exception{

		Map<String, Object> map = new HashMap<>();

		 Thedead thedead = hwaBookingService.findThedead(HwaBookingId.of(bookDate, bookChasu, bookChasuSeq));
		 HwaBooking booking = hwaBookingService.findOne(HwaBookingId.of(bookDate, bookChasu, bookChasuSeq));
		 //Applicant applicant = applicantService.isNewApplicant(booking.getBookApplJumin());

		 HwaBookingVTO hwaBookingVTO =HwaBookingVTO.of(booking);
		// ApplicantVTO applicantVTO =ApplicantVTO.of(applicant);
		 hwaBookingService.addFuneral(hwaBookingVTO);

		 hwaBookingVTO.setThedead(thedead);
		 map.put("hwaBooking", hwaBookingVTO);

		try {
			HistoryService.addHistory(String.format(
					"조회] 화장예약자료(%s-%s-%s) : 신청자 - %s"
					, bookDate
					, bookChasu
					, bookChasuSeq
					, hwaBookingVTO.getApplicant().getApplName()
					));
		}catch (Exception e) {
		}


		return CommonListResponseParams.MapResponse.of(map);
	}

	@RequestMapping(value="/CREM2010/hwaCremation", method=RequestMethod.PUT, produces=APPLICATION_JSON)
	public MapResponse saveHwaCremation(
				@RequestBody HwaCremationVTO hwaCremationVTO
			) throws Exception{
		Map<String, Object> result = hwaCremationService.saveHwaCremation(hwaCremationVTO);
		//eskyService.sendData();

		try {
			HistoryService.addHistory(String.format(
					"저장] 화장접수자료(%s-%s) : 신청자 - %s"
					, DateUtils.formatToDateString(hwaCremationVTO.getCremDate(), "yyyy-MM-dd")
					, hwaCremationVTO.getCremSeq()
					, hwaCremationVTO.getApplicant().getApplName()
					));
		}catch (Exception e) {
		}

		return CommonListResponseParams.MapResponse.of(result);
	}

	@RequestMapping(value="/CREM2010/hwaCremation/{cremDate}/{cremSeq}", method=RequestMethod.DELETE, produces=APPLICATION_JSON)
	public ApiResponse deleteHwaCremation(
			@PathVariable("cremDate") @DateTimeFormat(pattern="yyyyMMdd") Date cremDate
			, @PathVariable("cremSeq") Integer cremSeq
			) throws Exception{

		hwaCremationService.deleteHwaCremation(HwaCremationId.of(cremDate, cremSeq));


		try {
			HistoryService.addHistory(String.format(
					"삭제] 화장접수자료(%s-%s)"
					, DateUtils.formatToDateString(cremDate, "yyyy-MM-dd")
					, cremSeq
					));
		}catch (Exception e) {
		}

		return ok();
	}

	@RequestMapping(value="/CREM2010/addrCode/{addrName}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse getAddrCode(
			@PathVariable("addrName") String addrName
			) throws Exception{

		Map<String, Object> result = new HashMap<>();

		result.put("addrPartVTO", AddrpartVTO.of(addrpartService.findByAddrName(addrName)));

		return CommonListResponseParams.MapResponse.of(result);
	}

	@RequestMapping(value="/CREM2010/addrCode", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getAddrCodeOptionValue() throws Exception{

		return CommonListResponseParams.ListResponse.of(addrpartService.getAddrCodeOptionValue());
	}

	@RequestMapping(value="/CREM2010/addrCode/option", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public List<OptionVTO> getAddrCodeOption() throws Exception{
		List<Addrpart> list = addrpartService.findAll();
		List<OptionVTO> result = new ArrayList<>();
		list.forEach((item)->{
			result.add(OptionVTO.of(item.getAddrCode(), item.getAddrName()));
		});

		return result;
	}

	@RequestMapping(value="/CREM2010/pricelist/{jobGubun}/{priceGubun}/{objt}/{addrPart}/{dcCode}", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public CommonListResponseParams.MapResponse getPriceList(
			@PathVariable("jobGubun") String jobGubun
			,@PathVariable("priceGubun") String priceGubun
			,@PathVariable("objt") String objt
			, @PathVariable("addrPart") String addrPart
			, @PathVariable("dcCode") String dcCode
			){
		/**
		 * "C" : 화장
		 * "U" : 사용료
		 * "TCM1000001" : 관내
		 * "TCM1200001" : 일반
		 */
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
		if("E".equals(jobGubun)){
			if("U".equals(priceGubun)){
				res.put("mngAmt", pricelistService.findPrice(jobGubun, "M", objt, dcRate.getDcAddrPart()));
			}
		}

		res.put("pricelist", generalPricelist);
		res.put("generalPricelist", generalPricelist);
		res.put("dcRate", dcRate.getDcPercent());

		return CommonListResponseParams.MapResponse.of(res);
	}

	@ApiOperation(value = "화장차수", notes = "화로")
	@RequestMapping(value="/CREM2010/rogrpchasu/ro/option" , method= {RequestMethod.GET, RequestMethod.POST}, produces=APPLICATION_JSON )
	public List<OptionVTO> getRo() throws Exception{
		int totRocnt = Integer.parseInt(rogrpService.getInvokedRogrp(new Date()).getTotRocnt());
		List<OptionVTO> list = new ArrayList<>();
		for (int i = 1; i <= totRocnt; i++) {
			list.add(OptionVTO.of(StringUtils.leftPad(new Integer(i).toString(), 2, "0"), i+""));
		}
		return list;
	}

	@ApiOperation(value = "화장차수", notes = "차수시간")
	@RequestMapping(value="/CREM2010/rogrpchasu/chasuTime/option" , method= {RequestMethod.GET, RequestMethod.POST}, produces=APPLICATION_JSON )
	public List<OptionVTO> GetChasuTime() throws Exception{

		return this.rogrpchasuService.getInvokedChasu(new Date()).stream().map(chasu->
		OptionVTO.of(chasu.getChasuSeq(), chasu.getChasuName() + " "
		+ DateUtils.formatToDateString(chasu.getStrtime(),"HH:mm") +"~"
		+ DateUtils.formatToDateString(chasu.getEndtime(),"HH:mm"))).collect(Collectors.toList());
	}

	@ApiOperation(value = "감면율", notes = "감면율")
	@RequestMapping(value="/CREM2010/dcRate/" , method= {RequestMethod.GET, RequestMethod.POST}, produces=APPLICATION_JSON )
	public CommonListResponseParams.ListResponse getDcRate() throws Exception{
		return CommonListResponseParams.ListResponse.of(dcRateService.findAll());
	}

	@RequestMapping(value="/CREM2010/funeral" , method= {RequestMethod.GET}, produces=APPLICATION_JSON )
	public MapResponse getFuneral(String customerNo) throws Exception{

		Funeral funeral = this.funeralService.findOne(customerNo);

		List<Payment> payments = this.paymentService.findByDeadId(funeral.getDeadId());

		funeral.setPayment(payments);

		Map<String, Object> res = new HashMap<>();

		res.put("funeral", funeral);

		return MapResponse.of(res);
	}
}
