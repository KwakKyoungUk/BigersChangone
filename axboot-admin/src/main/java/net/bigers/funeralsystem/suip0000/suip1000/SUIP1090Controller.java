package net.bigers.funeralsystem.suip0000.suip1000;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PageableDefault;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.axisj.axboot.core.api.response.ApiResponse;

import net.bigers.funeralsystem.fune0000.domain.payment.Payment;
import net.bigers.funeralsystem.fune0000.domain.sale_stmt.SaleStmtService;
import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.suip0000.domain.allocr.Allocr;
import net.bigers.funeralsystem.suip0000.domain.allocr.AllocrService;
import net.bigers.funeralsystem.suip0000.domain.ocrlist.Ocrlist;
import net.bigers.funeralsystem.suip0000.domain.ocrlist.OcrlistService;
import net.bigers.funeralsystem.suip0000.domain.suipsum_day.SuipsumDayService;

@Controller
public class SUIP1090Controller extends BaseController{

	@Autowired
	private OcrlistService ocrlistService;

	@Autowired
	private SuipsumDayService suipsumDayService;

	@Autowired
	private AllocrService allocrService;

	@RequestMapping(value="/SUIP1090/fileupload", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public void fileupload(	@RequestBody List<Map<String, String>> requestBody) throws Exception{
		ocrlistService.saveOcrlist(requestBody);
	}

	@RequestMapping(value="/SUIP1090/ocrlist", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public List<Ocrlist> getAllocr(Ocrlist ocrlist, @PageableDefault(size=Integer.MAX_VALUE) Pageable pageable){
		return this.ocrlistService.searchMainOcr(ocrlist, pageable);
	}

	@RequestMapping(value="/SUIP1090/allocr", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deleteAllocr(@RequestBody List<Allocr> deleteList){
		this.allocrService.delete(deleteList);
		return ok();
	}

	@RequestMapping(value="/SUIP1090/allocr", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public ListResponse getOcrlist(@DateTimeFormat(pattern="yyyy-MM-dd") Date abdate){
		return ListResponse.of(this.allocrService.findByAbdate(abdate));
	}

	@RequestMapping(value="/SUIP1090/allocr/not", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public ListResponse getOcrlist(){
		return ListResponse.of(this.allocrService.getNotResultOcr());
	}

	@RequestMapping(value="/SUIP1090/allocr/receipt", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public ApiResponse postAllocrReceipt(@RequestBody List<Ocrlist> ocrlist) throws Exception{
		this.ocrlistService.receipt(ocrlist);
		return ok();
	}

	@RequestMapping(value="/SUIP1090/suip", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public List<Object> getSuip(@DateTimeFormat(pattern="yyyy-MM-dd") Date aprdate) throws Exception{
		return this.suipsumDayService.getSuip(aprdate);
	}

	@RequestMapping(value="/SUIP1090/getPayment", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public MapResponse getPayment(@RequestBody List<Date> aprDate) throws Exception{
		return MapResponse.of(MapUtils.getMap("list",suipsumDayService.getPayment(aprDate)));
	}


}