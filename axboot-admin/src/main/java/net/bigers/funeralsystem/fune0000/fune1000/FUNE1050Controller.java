package net.bigers.funeralsystem.fune0000.fune1000;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;

import net.bigers.funeralsystem.fune0000.domain.funeral.Funeral;
import net.bigers.funeralsystem.fune0000.domain.funeral.FuneralService;
import net.bigers.funeralsystem.fune0000.vto.FuneralDetailVTO;

@Controller
public class FUNE1050Controller extends BaseController{

	@Inject
	private BasicCodeService BasicCodeService;
	
	@Autowired
	private FuneralService funeralService;
	
	@RequestMapping(value="/FUNE1050/basiccode", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getBasicCode(){
		List<BasicCode> list = BasicCodeService.findByBasicCd("416");
		return CommonListResponseParams.ListResponse.of(list);
	}
	
	@RequestMapping(value="/FUNE1050/getFuneralDetail", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getFuneral(@RequestParam Map<String, String> requestBody){
		List<FuneralDetailVTO> list = funeralService.getFuneralDetail(requestBody);
		return CommonListResponseParams.ListResponse.of(list);
	}
	
	
}
