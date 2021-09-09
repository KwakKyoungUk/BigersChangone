package net.bigers.funeralsystem.ensh0000.ensh1000;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.axisj.axboot.admin.controllers.BaseController;
import com.axisj.axboot.admin.parameter.CommonListResponseParams.ListResponse;

import net.bigers.funeralsystem.crem0000.domain.hwacremation.HwaCremationService;
import net.bigers.funeralsystem.crem0000.vto.EnshCremStatusVTO;

@Controller
public class ENSH1001Controller extends BaseController  {

	@Autowired
	private HwaCremationService hwaCremationService;

	@RequestMapping(value="/ENSH1001/cremEnsData", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public ListResponse getSaleStmt(
			@DateTimeFormat(pattern="yyyy-MM-dd") Date cremDate
			, @RequestParam("area") List<String> area
			) throws Exception{

		List<EnshCremStatusVTO> res = this.hwaCremationService.selectEnshCremStatusData(cremDate, area);

		return ListResponse.of(res);
	}

}
