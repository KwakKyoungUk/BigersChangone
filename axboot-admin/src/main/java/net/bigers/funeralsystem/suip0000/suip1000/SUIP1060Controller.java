package net.bigers.funeralsystem.suip0000.suip1000;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.MapResponse;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;

import net.bigers.funeralsystem.common.vto.OptionVTO;
import net.bigers.funeralsystem.lib.util.MapUtils;
import net.bigers.funeralsystem.suip0000.domain.allocr.AllocrService;
import net.bigers.funeralsystem.suip0000.domain.suetc.Suetc;
import net.bigers.funeralsystem.suip0000.domain.suetc.SuetcService;

@Controller
public class SUIP1060Controller extends BaseController{

	@Autowired
	private SuetcService suetcService;

	@Autowired
	private BasicCodeService basicCodeService;

	@Autowired
	private AllocrService allocrService;

	@RequestMapping(value="/SUIP1060/suetc", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public ListResponse getSuetc(
			String searchKind
			, @RequestParam(required=false, defaultValue="1900-01-01") @DateTimeFormat(pattern="yyyy-MM-dd") Date from
			, @RequestParam(required=false, defaultValue="3000-12-31") @DateTimeFormat(pattern="yyyy-MM-dd") Date to
			, Sort sort
			) throws Exception{
		return ListResponse.of(suetcService.search(searchKind, from, to, sort));
	}

	@RequestMapping(value="/SUIP1060/code/gubunCd", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public List<OptionVTO> getCodeGubunCd(){
		List<BasicCode> gubunCd = basicCodeService.getSuetcGubunCd();
		return gubunCd.stream().map(gc->OptionVTO.of(gc.getCode(), gc.getName())).collect(Collectors.toList());
	}

	@RequestMapping(value="/SUIP1060/suetc", method={RequestMethod.PUT, RequestMethod.POST}, produces=APPLICATION_JSON)
	public ApiResponse saveSuetc(@RequestBody Suetc suetc) throws Exception{
		this.suetcService.save(suetc);
		return ok();
	}

	@RequestMapping(value="/SUIP1060/suetc", method={RequestMethod.DELETE}, produces=APPLICATION_JSON)
	public ApiResponse deleteSuetc(@RequestBody Suetc suetc) throws Exception{
		this.suetcService.delete(suetc);
		return ok();
	}

	@RequestMapping(value="/SUIP1060/allocr", method={RequestMethod.PUT, RequestMethod.POST}, produces=APPLICATION_JSON)
	public MapResponse saveAllocr(Long id) throws Exception{

		return MapResponse.of(MapUtils.getMap("suetc", this.allocrService.save(id)));
	}

	@RequestMapping(value="/SUIP1060/ocrband", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public MapResponse getOcrband(Long allocrId) throws Exception{

		return MapResponse.of(MapUtils.getMap("ocrband", this.allocrService.getOcrBand(allocrId)));
	}

}