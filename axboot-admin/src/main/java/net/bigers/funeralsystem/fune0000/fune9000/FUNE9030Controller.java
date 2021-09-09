package net.bigers.funeralsystem.fune0000.fune9000;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;

import net.bigers.funeralsystem.fune0000.domain.funeral.FuneralService;
import net.bigers.funeralsystem.fune0000.vto.FuneralVTO;

@Controller
public class FUNE9030Controller extends BaseController{

	@Inject
	private FuneralService funeralService;

	@RequestMapping(value="/FUNE9030/funeralCar", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getFuneralCar(String from, String to){

		return CommonListResponseParams.ListResponse.of(this.funeralService.getFuneralCarStat(from, to));
	}

}
