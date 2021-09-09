package net.bigers.funeralsystem.suip0000.suip1000;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.axisj.axboot.core.api.response.ApiResponse;

import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.suip0000.domain.allocr.AllocrService;
import net.bigers.funeralsystem.suip0000.domain.suipsum_day.SuipsumDay;
import net.bigers.funeralsystem.suip0000.domain.suipsum_day.SuipsumDayService;
import net.bigers.funeralsystem.suip0000.domain.suipsum_ocr_part.SuipsumOcrPart;
import net.bigers.funeralsystem.suip0000.domain.suipsum_ocr_part.SuipsumOcrPartService;
import net.bigers.funeralsystem.suip0000.vto.SuipsumDayVTO;

@Controller
public class SUIP1070Controller extends BaseController{

	@Autowired
	private SuipsumDayService suipsumDayService;

	@Autowired
	private SuipsumOcrPartService suipsumOcrPartService;

	@Autowired
	private AllocrService allocrService;

	@RequestMapping(value="/SUIP1070/calc", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public ListResponse getSuipsumDay(
			@DateTimeFormat(pattern="yyyy-MM-dd") Date sumdate
			, @DateTimeFormat(pattern="yyyy-MM-dd") Date sfrom
			, @DateTimeFormat(pattern="yyyy-MM-dd") Date sto
			) throws Exception{
		return ListResponse.of(this.suipsumDayService.calc(sumdate, sfrom, sto));
	}

//	@RequestMapping(value="/SUIP1070/allready/calc", method={RequestMethod.GET}, produces=APPLICATION_JSON)
//	public MapResponse getAllreadyCalc(
//			@DateTimeFormat(pattern="yyyy-MM-dd") Date sumdate
//			) throws Exception{
//		if(this.suipsumDayService.findBySumdate(sumdate).size()>0){
//			return MapResponse.of(MapUtils.getMap("isAllready", v));
//		}else{
//			return MapResponse.of();
//		}
//	}

	@RequestMapping(value="/SUIP1070/calc", method={RequestMethod.PUT, RequestMethod.POST}, produces=APPLICATION_JSON)
	public ApiResponse saveSuipsumDay(
			@RequestBody List<SuipsumDayVTO> suipsumDayVTO
			) throws Exception{

		this.suipsumDayService.saveSuipsum(suipsumDayVTO);
		return ok();
	}

	@RequestMapping(value="/SUIP1070/allocr", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public ListResponse saveAllocr(
			@DateTimeFormat(pattern="yyyy-MM-dd") Date sumdate
			) throws Exception{

		return ListResponse.of(this.allocrService.save(sumdate));
	}

	@RequestMapping(value="/SUIP1070/ocrband", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public MapResponse getOcrband(Long allocrId) throws Exception{

		return MapResponse.of(MapUtils.getMap("ocrband", this.allocrService.getOcrBand(allocrId)));
	}

	@RequestMapping(value="/SUIP1070/suipsum", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public MapResponse getOcrband(@DateTimeFormat(pattern="yyyy-MM-dd") Date sumdate) throws Exception{

		List<SuipsumDay> suipsumDay = this.suipsumDayService.findBySumdate(sumdate);

		List<SuipsumOcrPart> suipsumOcrPart = this.suipsumOcrPartService.findBySumdate(sumdate);

		Map<String, Object> res = MapUtils.getMap("suipsumDay", suipsumDay.stream().map(SuipsumDayVTO::new).collect(Collectors.toList()));
		res.put("suipsumOcrPart", suipsumOcrPart);

		return MapResponse.of(res);
	}
}