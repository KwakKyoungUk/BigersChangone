package net.bigers.funeralsystem.crem0000.crem2000;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.PageableResponseParams;
import com.axisj.axboot.core.dto.PageableTO;

import net.bigers.funeralsystem.crem0000.domain.hwacremation.HwaCremation;
import net.bigers.funeralsystem.crem0000.domain.hwacremation.HwaCremationService;

@Controller
public class CREM2021Controller extends BaseController {

	@Autowired
	private HwaCremationService hwaCremationService;

	@RequestMapping(value="/CREM2021/hwaCremation", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public PageableResponseParams.PageResponse getHwaCremation(
			String deadName
			, String applName
			, @DateTimeFormat(pattern="yyyy-MM-dd") Date from
			, @DateTimeFormat(pattern="yyyy-MM-dd") Date to
			, Pageable pageable
			) throws Exception{

		Page<HwaCremation> hwaCremationPage = hwaCremationService.findHwaCremation(deadName, applName, from, to, pageable);

		return PageableResponseParams.PageResponse.of(hwaCremationPage.getContent(), PageableTO.of(hwaCremationPage));
	}


}
