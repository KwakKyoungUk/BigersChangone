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

import net.bigers.funeralsystem.common.domain.history.History;
import net.bigers.funeralsystem.common.domain.history.HistoryService;

@Controller
public class HIST1010Controller  extends BaseController {

	@Autowired
	private HistoryService historyService;

	@RequestMapping(value="/HIST1010/history", method=RequestMethod.GET, produces=APPLICATION_JSON)
	public ListResponse getHistory(
			@RequestParam(defaultValue="") String user
			, @DateTimeFormat(pattern="yyyy-MM-dd") Date from
			, @DateTimeFormat(pattern="yyyy-MM-dd") Date to
			, @RequestParam(defaultValue="") String workContents
			) throws Exception{

		List<History> historys = this.historyService.findByUserAndRequestTime(user, from, to, workContents);

		return ListResponse.of(historys);
	}


}
