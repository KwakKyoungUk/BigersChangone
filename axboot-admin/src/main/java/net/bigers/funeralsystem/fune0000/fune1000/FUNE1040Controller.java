package net.bigers.funeralsystem.fune0000.fune1000;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams;
import com.axisj.axboot.admin.parameter.PageableResponseParams.PageResponse;
import com.axisj.axboot.core.domain.code.BasicCode;
import com.axisj.axboot.core.domain.code.BasicCodeService;
import com.axisj.axboot.core.dto.PageableTO;

import net.bigers.funeralsystem.fune0000.domain.funeral.Funeral;
import net.bigers.funeralsystem.fune0000.domain.funeral.FuneralService;

@Controller
public class FUNE1040Controller extends BaseController{

	@Inject
	private BasicCodeService BasicCodeService;

	@Autowired
	private FuneralService funeralService;

	@RequestMapping(value="/FUNE1040/basiccode", method={RequestMethod.POST}, produces=APPLICATION_JSON)
	public CommonListResponseParams.ListResponse getBasicCode(){
		List<BasicCode> list = BasicCodeService.findByBasicCd("110");
		return CommonListResponseParams.ListResponse.of(list);
	}

	@RequestMapping(value="/FUNE1040/funeral", method={RequestMethod.GET}, produces=APPLICATION_JSON)
	public PageResponse getFuneral(
			@RequestParam Map<String, String> params
			, Pageable pageable
			){
		Page<Funeral> list = this.funeralService.findFuneral(params, pageable);
		return PageResponse.of(list.getContent(), PageableTO.of(list));
	}


}
