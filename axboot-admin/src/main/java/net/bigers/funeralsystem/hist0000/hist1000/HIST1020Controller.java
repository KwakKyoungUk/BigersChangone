package net.bigers.funeralsystem.hist0000.hist1000;

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

import net.bigers.funeralsystem.common.domain.loginHistory.LoginHistory;
import net.bigers.funeralsystem.common.domain.loginHistory.LoginHistoryService;

@Controller
public class HIST1020Controller  extends BaseController {

	@Autowired
	private LoginHistoryService loginHistoryService;

	@RequestMapping(value="/HIST1020/loginHistory", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public ListResponse getHistory(@RequestParam() String condition
								 , @RequestParam(required = false) String searchParam
								 , @RequestParam(required = false) String allCheck								 
								 , @RequestParam(required = false) @DateTimeFormat(pattern="yyyy-MM-dd") Date from
			                     , @RequestParam(required = false) @DateTimeFormat(pattern="yyyy-MM-dd") Date to) throws Exception{

		List<LoginHistory> loginHistorys = this.loginHistoryService.getLoginHistory(condition, searchParam, allCheck, from, to);

		return ListResponse.of(loginHistorys);
	}


}
