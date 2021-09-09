package net.bigers.funeralsystem.guid0000.guid1000;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.util.DateUtils;
import com.wordnik.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/display/public/")
public class GUID1010Controller extends BaseController {

	@ApiOperation(value = "키오스크 화면", notes = "고인검색 키오스크 메인화면")
	@RequestMapping(value="/GUID1010/{machineCd}" , method= RequestMethod.GET )
	public String main(@PathVariable (value="machineCd") String machineCd ,Model model) throws Exception{
		
		model.addAttribute(machineCd);
		return "/jsp/funeralsystem/display/public/guid/GUID1010";
	}
	
	
	
	@ApiOperation(value = "운영환경 정보", notes = "운영환경 정보를 조회")
	@RequestMapping(value="GUID1010/selectSetting" ,method = RequestMethod.GET, produces = APPLICATION_JSON)
	public CommonListResponseParams.MapResponse selectEnv() throws Exception{
		//Double version = programVersionRepository.findAll().get(0).getVersion();
		String stDate = DateUtils.formatToDateString("yyyyMMddHHmm");			
		Map<String, Object> map= new HashMap<String, Object>();
		
	
		SimpleDateFormat sdf = new SimpleDateFormat("M월 dd일 E요일 ,a HH:mm");		
		map.put("time", sdf.format(new Date()));		
				
		return CommonListResponseParams.MapResponse.of(map);
	}
}
